import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../database/app_database.dart';
import '../../core/constants/supabase_config.dart';

/// Syncs local Drift SQLite data with Supabase cloud.
/// Supports 2-way synchronization:
/// - Upload: local orders & ingredient stock updates push to Supabase
/// - Realtime: listens to INSERT/UPDATE/DELETE on orders, menu_items, categories, ingredients
/// - Pull: full reconciliation on startup or manual sync
class SyncService {
  final AppDatabase db;
  final SupabaseClient client;

  RealtimeChannel? _channel;
  final ValueNotifier<bool> isRealtimeConnected = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isSyncing = ValueNotifier<bool>(false);
  final ValueNotifier<DateTime?> lastSyncedAt = ValueNotifier<DateTime?>(null);

  SyncService({required this.db, required this.client});

  bool get _isConfigured => SupabaseConfig.isConfigured;

  // ── Initialise Realtime Listeners ──────────────────────────────────────────

  void initRealtime() {
    if (!_isConfigured) return;

    try {
      _channel?.unsubscribe();
      _channel = client.channel('public:usaha_pos_sync')
        // Orders
        ..onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'orders',
          callback: (payload) => _handleOrderDelete(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'orders',
          callback: (payload) => _handleOrderUpsert(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'orders',
          callback: (payload) => _handleOrderUpsert(payload),
        )
        // Menu Items
        ..onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'menu_items',
          callback: (payload) => _handleMenuItemDelete(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'menu_items',
          callback: (payload) => _handleMenuItemUpsert(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'menu_items',
          callback: (payload) => _handleMenuItemUpsert(payload),
        )
        // Categories
        ..onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'categories',
          callback: (payload) => _handleCategoryDelete(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'categories',
          callback: (payload) => _handleCategoryUpsert(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'categories',
          callback: (payload) => _handleCategoryUpsert(payload),
        )
        // Ingredients
        ..onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'ingredients',
          callback: (payload) => _handleIngredientDelete(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'ingredients',
          callback: (payload) => _handleIngredientUpsert(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'ingredients',
          callback: (payload) => _handleIngredientUpsert(payload),
        )
        ..subscribe((status, error) {
          if (status == RealtimeSubscribeStatus.subscribed) {
            isRealtimeConnected.value = true;
            debugPrint('[SyncService] ✅ Realtime connected to Supabase');
          } else if (status == RealtimeSubscribeStatus.closed ||
              status == RealtimeSubscribeStatus.timedOut) {
            isRealtimeConnected.value = false;
            debugPrint('[SyncService] ⚠️ Realtime status: $status (error: $error)');
          }
        });
    } catch (e) {
      debugPrint('[SyncService] Failed to init realtime: $e');
    }
  }

  // ── Realtime Event Handlers ────────────────────────────────────────────────

  Future<void> _handleOrderDelete(PostgresChangePayload payload) async {
    try {
      debugPrint('[SyncService] 🔴 Realtime Order DELETE payload: ${payload.oldRecord}');
      final orderNumber = payload.oldRecord['order_number'] as String?;
      if (orderNumber != null) {
        await db.deleteOrderByOrderNumber(orderNumber);
      } else {
        // Fallback: reconcile today's orders if replica identity is default
        await syncOrders();
      }
    } catch (e) {
      debugPrint('[SyncService] Error handling order delete: $e');
    }
  }

  Future<void> _handleOrderUpsert(PostgresChangePayload payload) async {
    try {
      debugPrint('[SyncService] 🟢 Realtime Order UPSERT payload: ${payload.newRecord}');
      final rec = payload.newRecord;
      final orderNumber = rec['order_number'] as String?;
      if (orderNumber == null) return;

      final remoteOrderId = rec['id'];
      List<OrderItemsCompanion> items = [];
      if (remoteOrderId != null) {
        final itemsRes =
            await client.from('order_items').select().eq('order_id', remoteOrderId);
        items = (itemsRes as List).map((i) {
          return OrderItemsCompanion(
            menuItemId: Value(i['menu_item_id'] as int? ?? 0),
            itemName: Value(i['item_name'] as String? ?? ''),
            quantity: Value(i['quantity'] as int? ?? 1),
            unitPrice: Value((i['unit_price'] as num?)?.toDouble() ?? 0.0),
            subtotal: Value((i['subtotal'] as num?)?.toDouble() ?? 0.0),
            modifiers: Value(i['modifiers'] as String? ?? ''),
          );
        }).toList();
      }

      await db.upsertOrderFromRemote(
        OrdersCompanion(
          orderNumber: Value(orderNumber),
          orderType: Value(rec['order_type'] as String? ?? 'takeaway'),
          tableNumber: Value(rec['table_number'] as int?),
          status: Value(rec['status'] as String? ?? 'pending'),
          createdAt: Value(
            DateTime.tryParse(rec['created_at']?.toString() ?? '') ?? DateTime.now(),
          ),
          completedAt: Value(
            rec['completed_at'] != null
                ? DateTime.tryParse(rec['completed_at'].toString())
                : null,
          ),
          subtotal: Value((rec['subtotal'] as num?)?.toDouble() ?? 0.0),
          taxAmount: Value((rec['tax_amount'] as num?)?.toDouble() ?? 0.0),
          totalAmount: Value((rec['total_amount'] as num?)?.toDouble() ?? 0.0),
          paymentMethod: Value(rec['payment_method'] as String?),
          tenderedAmount: Value((rec['tendered_amount'] as num?)?.toDouble()),
          notes: Value(rec['notes'] as String? ?? ''),
        ),
        items,
      );
    } catch (e) {
      debugPrint('[SyncService] Error handling order upsert: $e');
    }
  }

  Future<void> _handleMenuItemDelete(PostgresChangePayload payload) async {
    try {
      debugPrint('[SyncService] 🔴 Realtime MenuItem DELETE: ${payload.oldRecord}');
      final id = payload.oldRecord['id'] as int?;
      final name = payload.oldRecord['name'] as String?;
      if (id != null) {
        await db.deleteMenuItemById(id);
      } else if (name != null) {
        await db.deleteMenuItemByName(name);
      } else {
        await syncMenuItems();
      }
    } catch (e) {
      debugPrint('[SyncService] Error handling menu item delete: $e');
    }
  }

  Future<void> _handleMenuItemUpsert(PostgresChangePayload payload) async {
    try {
      debugPrint('[SyncService] 🟢 Realtime MenuItem UPSERT: ${payload.newRecord}');
      final rec = payload.newRecord;
      final id = rec['id'] as int?;
      if (id == null) return;

      await db.upsertMenuItem(
        MenuItemsCompanion(
          id: Value(id),
          categoryId: Value(rec['category_id'] as int? ?? 1),
          name: Value(rec['name'] as String? ?? ''),
          description: Value(rec['description'] as String? ?? ''),
          basePrice: Value((rec['base_price'] as num?)?.toDouble() ?? 0.0),
          imageUrl: Value(rec['image_url'] as String?),
          isAvailable: Value(rec['is_available'] as bool? ?? true),
          preparationStation:
              Value(rec['preparation_station'] as String? ?? 'kitchen'),
        ),
      );
    } catch (e) {
      debugPrint('[SyncService] Error handling menu item upsert: $e');
    }
  }

  Future<void> _handleCategoryDelete(PostgresChangePayload payload) async {
    try {
      debugPrint('[SyncService] 🔴 Realtime Category DELETE: ${payload.oldRecord}');
      final id = payload.oldRecord['id'] as int?;
      if (id != null) {
        await db.deleteCategoryById(id);
      } else {
        await syncCategories();
      }
    } catch (e) {
      debugPrint('[SyncService] Error handling category delete: $e');
    }
  }

  Future<void> _handleCategoryUpsert(PostgresChangePayload payload) async {
    try {
      debugPrint('[SyncService] 🟢 Realtime Category UPSERT: ${payload.newRecord}');
      final rec = payload.newRecord;
      final id = rec['id'] as int?;
      if (id == null) return;

      await db.upsertCategory(
        CategoriesCompanion(
          id: Value(id),
          name: Value(rec['name'] as String? ?? ''),
          iconCode: Value(rec['icon_code'] as String? ?? 'e532'),
          colorHex: Value(rec['color_hex'] as String? ?? '#C17F3A'),
          sortOrder: Value(rec['sort_order'] as int? ?? 0),
        ),
      );
    } catch (e) {
      debugPrint('[SyncService] Error handling category upsert: $e');
    }
  }

  Future<void> _handleIngredientDelete(PostgresChangePayload payload) async {
    try {
      debugPrint('[SyncService] 🔴 Realtime Ingredient DELETE: ${payload.oldRecord}');
      final name = payload.oldRecord['name'] as String?;
      final id = payload.oldRecord['id'] as int?;
      if (name != null) {
        await db.deleteIngredientByName(name);
      } else if (id != null) {
        await db.deleteIngredientById(id);
      } else {
        await syncIngredients();
      }
    } catch (e) {
      debugPrint('[SyncService] Error handling ingredient delete: $e');
    }
  }

  Future<void> _handleIngredientUpsert(PostgresChangePayload payload) async {
    try {
      debugPrint('[SyncService] 🟢 Realtime Ingredient UPSERT: ${payload.newRecord}');
      final rec = payload.newRecord;
      await db.upsertIngredient(
        IngredientsCompanion(
          name: Value(rec['name'] as String? ?? ''),
          unit: Value(rec['unit'] as String? ?? 'unit'),
          currentStock:
              Value((rec['current_stock'] as num?)?.toDouble() ?? 0.0),
          reorderPoint:
              Value((rec['reorder_point'] as num?)?.toDouble() ?? 0.0),
          costPerUnit: Value((rec['cost_per_unit'] as num?)?.toDouble() ?? 0.0),
        ),
      );
    } catch (e) {
      debugPrint('[SyncService] Error handling ingredient upsert: $e');
    }
  }

  // ── Pull & Full Reconciliation ─────────────────────────────────────────────

  Future<void> pullAllFromSupabase() async {
    if (!_isConfigured) return;
    isSyncing.value = true;
    try {
      await syncCategories();
      await syncMenuItems();
      await syncIngredients();
      await syncOrders();
      lastSyncedAt.value = DateTime.now();
      debugPrint('[SyncService] 🔄 Full pull sync completed successfully');
    } catch (e) {
      debugPrint('[SyncService] Full pull sync failed: $e');
    } finally {
      isSyncing.value = false;
    }
  }

  Future<void> syncCategories() async {
    if (!_isConfigured) return;
    try {
      final List<dynamic> remote = await client.from('categories').select();
      if (remote.isEmpty) {
        // If remote is empty, seed remote from local
        final local = await db.getAllCategories();
        for (final c in local) {
          await client.from('categories').upsert({
            'name': c.name,
            'icon_code': c.iconCode,
            'color_hex': c.colorHex,
            'sort_order': c.sortOrder,
          });
        }
        return;
      }

      final remoteIds = <int>[];
      for (final r in remote) {
        final id = r['id'] as int;
        remoteIds.add(id);
        await db.upsertCategory(
          CategoriesCompanion(
            id: Value(id),
            name: Value(r['name'] as String? ?? ''),
            iconCode: Value(r['icon_code'] as String? ?? 'e532'),
            colorHex: Value(r['color_hex'] as String? ?? '#C17F3A'),
            sortOrder: Value(r['sort_order'] as int? ?? 0),
          ),
        );
      }
      await db.deleteCategoriesNotIn(remoteIds);
    } catch (e) {
      debugPrint('[SyncService] syncCategories error: $e');
    }
  }

  Future<void> syncMenuItems() async {
    if (!_isConfigured) return;
    try {
      final List<dynamic> remote = await client.from('menu_items').select();
      if (remote.isEmpty) {
        final local = await db.getAllMenuItems();
        for (final m in local) {
          await client.from('menu_items').upsert({
            'category_id': m.categoryId,
            'name': m.name,
            'description': m.description,
            'base_price': m.basePrice,
            'image_url': m.imageUrl,
            'is_available': m.isAvailable,
            'preparation_station': m.preparationStation,
          });
        }
        return;
      }

      final remoteIds = <int>[];
      for (final r in remote) {
        final id = r['id'] as int;
        remoteIds.add(id);
        await db.upsertMenuItem(
          MenuItemsCompanion(
            id: Value(id),
            categoryId: Value(r['category_id'] as int? ?? 1),
            name: Value(r['name'] as String? ?? ''),
            description: Value(r['description'] as String? ?? ''),
            basePrice: Value((r['base_price'] as num?)?.toDouble() ?? 0.0),
            imageUrl: Value(r['image_url'] as String?),
            isAvailable: Value(r['is_available'] as bool? ?? true),
            preparationStation:
                Value(r['preparation_station'] as String? ?? 'kitchen'),
          ),
        );
      }
      await db.deleteMenuItemsNotIn(remoteIds);
    } catch (e) {
      debugPrint('[SyncService] syncMenuItems error: $e');
    }
  }

  Future<void> syncIngredients() async {
    if (!_isConfigured) return;
    try {
      final List<dynamic> remote = await client.from('ingredients').select();
      if (remote.isEmpty) {
        final local = await db.getAllIngredients();
        for (final ing in local) {
          await client.from('ingredients').upsert({
            'name': ing.name,
            'unit': ing.unit,
            'current_stock': ing.currentStock,
            'reorder_point': ing.reorderPoint,
            'cost_per_unit': ing.costPerUnit,
          }, onConflict: 'name');
        }
        return;
      }

      for (final r in remote) {
        await db.upsertIngredient(
          IngredientsCompanion(
            name: Value(r['name'] as String? ?? ''),
            unit: Value(r['unit'] as String? ?? 'unit'),
            currentStock:
                Value((r['current_stock'] as num?)?.toDouble() ?? 0.0),
            reorderPoint:
                Value((r['reorder_point'] as num?)?.toDouble() ?? 0.0),
            costPerUnit:
                Value((r['cost_per_unit'] as num?)?.toDouble() ?? 0.0),
          ),
        );
      }
    } catch (e) {
      debugPrint('[SyncService] syncIngredients error: $e');
    }
  }

  Future<void> syncOrders() async {
    if (!_isConfigured) return;
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final List<dynamic> remote = await client
          .from('orders')
          .select('*, order_items(*)')
          .gte('created_at', startOfDay.toIso8601String());

      final remoteOrderNumbers = <String>[];
      for (final r in remote) {
        final orderNumber = r['order_number'] as String?;
        if (orderNumber == null) continue;
        remoteOrderNumbers.add(orderNumber);

        final rawItems = (r['order_items'] as List?) ?? [];
        final itemCompanions = rawItems.map((i) {
          return OrderItemsCompanion(
            menuItemId: Value(i['menu_item_id'] as int? ?? 0),
            itemName: Value(i['item_name'] as String? ?? ''),
            quantity: Value(i['quantity'] as int? ?? 1),
            unitPrice: Value((i['unit_price'] as num?)?.toDouble() ?? 0.0),
            subtotal: Value((i['subtotal'] as num?)?.toDouble() ?? 0.0),
            modifiers: Value(i['modifiers'] as String? ?? ''),
          );
        }).toList();

        await db.upsertOrderFromRemote(
          OrdersCompanion(
            orderNumber: Value(orderNumber),
            orderType: Value(r['order_type'] as String? ?? 'takeaway'),
            tableNumber: Value(r['table_number'] as int?),
            status: Value(r['status'] as String? ?? 'pending'),
            createdAt: Value(
              DateTime.tryParse(r['created_at']?.toString() ?? '') ??
                  DateTime.now(),
            ),
            completedAt: Value(
              r['completed_at'] != null
                  ? DateTime.tryParse(r['completed_at'].toString())
                  : null,
            ),
            subtotal: Value((r['subtotal'] as num?)?.toDouble() ?? 0.0),
            taxAmount: Value((r['tax_amount'] as num?)?.toDouble() ?? 0.0),
            totalAmount: Value((r['total_amount'] as num?)?.toDouble() ?? 0.0),
            paymentMethod: Value(r['payment_method'] as String?),
            tenderedAmount: Value((r['tendered_amount'] as num?)?.toDouble()),
            notes: Value(r['notes'] as String? ?? ''),
          ),
          itemCompanions,
        );
      }

      // Reconcile: delete local orders created today that are no longer in Supabase
      await db.deleteOrdersNotIn(remoteOrderNumbers, since: startOfDay);
    } catch (e) {
      debugPrint('[SyncService] syncOrders error: $e');
    }
  }

  // ── Upload a completed order to Supabase ───────────────────────────────────

  Future<void> syncCompletedOrder(int localOrderId) async {
    if (!_isConfigured) return;
    try {
      final order = await db.getOrder(localOrderId);
      if (order == null) return;

      final result = await client.from('orders').insert({
        'order_number': order.orderNumber,
        'order_type': order.orderType,
        'table_number': order.tableNumber,
        'status': order.status,
        'created_at': order.createdAt.toIso8601String(),
        'completed_at': order.completedAt?.toIso8601String(),
        'subtotal': order.subtotal,
        'tax_amount': order.taxAmount,
        'total_amount': order.totalAmount,
        'payment_method': order.paymentMethod,
        'tendered_amount': order.tenderedAmount,
        'notes': order.notes,
      }).select('id').single();

      final remoteOrderId = result['id'] as int;

      final items = await db.getOrderItems(localOrderId);
      for (final item in items) {
        await client.from('order_items').insert({
          'order_id': remoteOrderId,
          'menu_item_id': item.menuItemId,
          'item_name': item.itemName,
          'quantity': item.quantity,
          'unit_price': item.unitPrice,
          'subtotal': item.subtotal,
          'modifiers': item.modifiers,
        });
      }
    } catch (e) {
      debugPrint('[SyncService] Order upload failed: $e');
    }
  }

  // ── Push ingredient stock update to Supabase ───────────────────────────────

  Future<void> syncIngredientStock(
      String ingredientName, double newStock) async {
    if (!_isConfigured) return;
    try {
      await client.from('ingredients').update({
        'current_stock': newStock,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('name', ingredientName);
    } catch (e) {
      debugPrint('[SyncService] Ingredient sync failed: $e');
    }
  }

  void dispose() {
    _channel?.unsubscribe();
    isRealtimeConnected.dispose();
    isSyncing.dispose();
    lastSyncedAt.dispose();
  }
}
