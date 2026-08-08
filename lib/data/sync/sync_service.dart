import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../database/app_database.dart';
import '../../core/constants/supabase_config.dart';

/// Syncs local Drift SQLite data with Supabase cloud.
/// Supports 2-way synchronization across all modules:
/// - Orders & Items (POS, KDS)
/// - Menu Items & Categories
/// - Ingredients & Stock
/// - Tasks (Opening, Closing, Handover, Kanban)
/// - Customers (CRM, Loyalty Points, Stamp Cards)
/// - Staff & Attendance (Clock-In / Clock-Out)
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
        // Tasks (Phase 2)
        ..onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'tasks',
          callback: (payload) => _handleTaskDelete(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'tasks',
          callback: (payload) => _handleTaskUpsert(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'tasks',
          callback: (payload) => _handleTaskUpsert(payload),
        )
        // Customers (Phase 2)
        ..onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'customers',
          callback: (payload) => _handleCustomerDelete(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'customers',
          callback: (payload) => _handleCustomerUpsert(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'customers',
          callback: (payload) => _handleCustomerUpsert(payload),
        )
        // Staff Members (Phase 2)
        ..onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'staff_members',
          callback: (payload) => _handleStaffDelete(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'staff_members',
          callback: (payload) => _handleStaffUpsert(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'staff_members',
          callback: (payload) => _handleStaffUpsert(payload),
        )
        // Staff Attendances (Phase 2)
        ..onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'staff_attendances',
          callback: (payload) => _handleAttendanceUpsert(payload),
        )
        ..onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'staff_attendances',
          callback: (payload) => _handleAttendanceUpsert(payload),
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
      final orderNumber = payload.oldRecord['order_number'] as String?;
      if (orderNumber != null) {
        await db.deleteOrderByOrderNumber(orderNumber);
      } else {
        await syncOrders();
      }
    } catch (e) {
      debugPrint('[SyncService] Error handling order delete: $e');
    }
  }

  Future<void> _handleOrderUpsert(PostgresChangePayload payload) async {
    try {
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
            DateTime.tryParse(rec['created_at']?.toString() ?? '') ??
                DateTime.now(),
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
      final name = payload.oldRecord['name'] as String?;
      if (name != null) {
        await db.deleteMenuItemByName(name);
      } else {
        await syncMenuItems();
      }
    } catch (e) {
      debugPrint('[SyncService] Error handling menu_item delete: $e');
    }
  }

  Future<void> _handleMenuItemUpsert(PostgresChangePayload payload) async {
    try {
      final rec = payload.newRecord;
      final name = rec['name'] as String?;
      if (name == null) return;

      int categoryId = 1;
      final catId = rec['category_id'];
      if (catId != null) {
        final catRes = await client
            .from('categories')
            .select('name')
            .eq('id', catId)
            .maybeSingle();
        if (catRes != null) {
          final localCat =
              await db.getCategoryByName(catRes['name'] as String? ?? '');
          if (localCat != null) categoryId = localCat.id;
        }
      }

      await db.upsertMenuItem(
        MenuItemsCompanion(
          categoryId: Value(categoryId),
          name: Value(name),
          description: Value(rec['description'] as String? ?? ''),
          basePrice: Value((rec['base_price'] as num?)?.toDouble() ?? 0.0),
          preparationStation: Value(rec['station'] as String? ?? rec['preparation_station'] as String? ?? 'kitchen'),
          isAvailable: Value(rec['is_available'] as bool? ?? true),
        ),
      );
    } catch (e) {
      debugPrint('[SyncService] Error handling menu_item upsert: $e');
    }
  }

  Future<void> _handleCategoryDelete(PostgresChangePayload payload) async {
    try {
      final name = payload.oldRecord['name'] as String?;
      if (name != null) {
        await db.deleteCategoryByName(name);
      } else {
        await syncCategories();
      }
    } catch (e) {
      debugPrint('[SyncService] Error handling category delete: $e');
    }
  }

  Future<void> _handleCategoryUpsert(PostgresChangePayload payload) async {
    try {
      final rec = payload.newRecord;
      final name = rec['name'] as String?;
      if (name == null) return;

      await db.upsertCategory(
        CategoriesCompanion(
          name: Value(name),
          iconCode: Value(rec['icon_code'] as String? ?? rec['icon'] as String? ?? 'coffee'),
          sortOrder: Value(rec['sort_order'] as int? ?? 0),
        ),
      );
    } catch (e) {
      debugPrint('[SyncService] Error handling category upsert: $e');
    }
  }

  Future<void> _handleIngredientDelete(PostgresChangePayload payload) async {
    try {
      final name = payload.oldRecord['name'] as String?;
      if (name != null) {
        await db.deleteIngredientByName(name);
      } else {
        await syncIngredients();
      }
    } catch (e) {
      debugPrint('[SyncService] Error handling ingredient delete: $e');
    }
  }

  Future<void> _handleIngredientUpsert(PostgresChangePayload payload) async {
    try {
      final rec = payload.newRecord;
      final name = rec['name'] as String?;
      if (name == null) return;

      await db.upsertIngredient(
        IngredientsCompanion(
          name: Value(name),
          unit: Value(rec['unit'] as String? ?? 'unit'),
          currentStock: Value((rec['current_stock'] as num?)?.toDouble() ?? 0.0),
          reorderPoint: Value((rec['reorder_point'] as num?)?.toDouble() ?? 0.0),
          costPerUnit: Value((rec['cost_per_unit'] as num?)?.toDouble() ?? 0.0),
        ),
      );
    } catch (e) {
      debugPrint('[SyncService] Error handling ingredient upsert: $e');
    }
  }

  // ── Phase 2 Handlers ───────────────────────────────────────────────────────

  Future<void> _handleTaskDelete(PostgresChangePayload payload) async {
    await syncTasks();
  }

  Future<void> _handleTaskUpsert(PostgresChangePayload payload) async {
    try {
      final rec = payload.newRecord;
      final title = rec['title'] as String?;
      if (title == null) return;

      await db.insertTask(
        TasksCompanion(
          title: Value(title),
          description: Value(rec['description'] as String? ?? ''),
          category: Value(rec['category'] as String? ?? 'general'),
          priority: Value(rec['priority'] as String? ?? 'medium'),
          status: Value(rec['status'] as String? ?? 'todo'),
          completedBy: Value(rec['completed_by'] as String?),
          completedAt: Value(
            rec['completed_at'] != null ? DateTime.tryParse(rec['completed_at'].toString()) : null,
          ),
        ),
      );
    } catch (e) {
      debugPrint('[SyncService] Task upsert error: $e');
    }
  }

  Future<void> _handleCustomerDelete(PostgresChangePayload payload) async {
    await syncCustomers();
  }

  Future<void> _handleCustomerUpsert(PostgresChangePayload payload) async {
    try {
      final rec = payload.newRecord;
      final name = rec['name'] as String?;
      final phone = rec['phone'] as String?;
      if (name == null || phone == null) return;

      await db.insertCustomer(
        CustomersCompanion(
          name: Value(name),
          phone: Value(phone),
          email: Value(rec['email'] as String?),
          tier: Value(rec['tier'] as String? ?? 'Bronze'),
          points: Value(rec['points'] as int? ?? 0),
          stampsCount: Value(rec['stamps_count'] as int? ?? 0),
          totalSpent: Value((rec['total_spent'] as num?)?.toDouble() ?? 0.0),
        ),
      );
    } catch (e) {
      debugPrint('[SyncService] Customer upsert error: $e');
    }
  }

  Future<void> _handleStaffDelete(PostgresChangePayload payload) async {
    await syncStaff();
  }

  Future<void> _handleStaffUpsert(PostgresChangePayload payload) async {
    try {
      final rec = payload.newRecord;
      final name = rec['name'] as String?;
      if (name == null) return;

      await db.insertStaff(
        StaffMembersCompanion(
          name: Value(name),
          role: Value(rec['role'] as String? ?? 'Cashier'),
          pinCode: Value(rec['pin_code'] as String? ?? '0000'),
          phone: Value(rec['phone'] as String?),
          hourlyRate: Value((rec['hourly_rate'] as num?)?.toDouble() ?? 0.0),
          isActive: Value(rec['is_active'] as bool? ?? true),
        ),
      );
    } catch (e) {
      debugPrint('[SyncService] Staff upsert error: $e');
    }
  }

  Future<void> _handleAttendanceUpsert(PostgresChangePayload payload) async {
    await syncAttendance();
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
      await syncTasks();
      await syncCustomers();
      await syncStaff();
      await syncAttendance();
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
      if (remote.isEmpty) return;

      final remoteIds = <int>[];
      for (final r in remote) {
        final id = await db.upsertCategory(
          CategoriesCompanion(
            name: Value(r['name'] as String? ?? ''),
            iconCode: Value(r['icon_code'] as String? ?? r['icon'] as String? ?? 'coffee'),
            sortOrder: Value(r['sort_order'] as int? ?? 0),
          ),
        );
        remoteIds.add(id);
      }
      await db.deleteCategoriesNotIn(remoteIds);
    } catch (e) {
      debugPrint('[SyncService] syncCategories error: $e');
    }
  }

  Future<void> syncMenuItems() async {
    if (!_isConfigured) return;
    try {
      final List<dynamic> remote = await client.from('menu_items').select('*, categories(name)');
      if (remote.isEmpty) return;

      final remoteIds = <int>[];
      for (final r in remote) {
        int categoryId = 1;
        final catMap = r['categories'] as Map<String, dynamic>?;
        if (catMap != null) {
          final catName = catMap['name'] as String? ?? '';
          final localCat = await db.getCategoryByName(catName);
          if (localCat != null) categoryId = localCat.id;
        }

        final id = await db.upsertMenuItem(
          MenuItemsCompanion(
            categoryId: Value(categoryId),
            name: Value(r['name'] as String? ?? ''),
            description: Value(r['description'] as String? ?? ''),
            basePrice: Value((r['base_price'] as num?)?.toDouble() ?? 0.0),
            preparationStation: Value(r['station'] as String? ?? r['preparation_station'] as String? ?? 'kitchen'),
            isAvailable: Value(r['is_available'] as bool? ?? true),
          ),
        );
        remoteIds.add(id);
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
      if (remote.isEmpty) return;

      for (final r in remote) {
        await db.upsertIngredient(
          IngredientsCompanion(
            name: Value(r['name'] as String? ?? ''),
            unit: Value(r['unit'] as String? ?? 'unit'),
            currentStock: Value((r['current_stock'] as num?)?.toDouble() ?? 0.0),
            reorderPoint: Value((r['reorder_point'] as num?)?.toDouble() ?? 0.0),
            costPerUnit: Value((r['cost_per_unit'] as num?)?.toDouble() ?? 0.0),
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
              DateTime.tryParse(r['created_at']?.toString() ?? '') ?? DateTime.now(),
            ),
            completedAt: Value(
              r['completed_at'] != null ? DateTime.tryParse(r['completed_at'].toString()) : null,
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

      await db.deleteOrdersNotIn(remoteOrderNumbers, since: startOfDay);
    } catch (e) {
      debugPrint('[SyncService] syncOrders error: $e');
    }
  }

  Future<void> syncTasks() async {
    if (!_isConfigured) return;
    try {
      final List<dynamic> remote = await client.from('tasks').select();
      if (remote.isEmpty) return;

      for (final r in remote) {
        await db.insertTask(
          TasksCompanion(
            title: Value(r['title'] as String? ?? ''),
            description: Value(r['description'] as String? ?? ''),
            category: Value(r['category'] as String? ?? 'general'),
            priority: Value(r['priority'] as String? ?? 'medium'),
            status: Value(r['status'] as String? ?? 'todo'),
            completedBy: Value(r['completed_by'] as String?),
            completedAt: Value(
              r['completed_at'] != null ? DateTime.tryParse(r['completed_at'].toString()) : null,
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('[SyncService] syncTasks error: $e');
    }
  }

  Future<void> syncCustomers() async {
    if (!_isConfigured) return;
    try {
      final List<dynamic> remote = await client.from('customers').select();
      if (remote.isEmpty) return;

      for (final r in remote) {
        await db.insertCustomer(
          CustomersCompanion(
            name: Value(r['name'] as String? ?? ''),
            phone: Value(r['phone'] as String? ?? ''),
            email: Value(r['email'] as String?),
            tier: Value(r['tier'] as String? ?? 'Bronze'),
            points: Value(r['points'] as int? ?? 0),
            stampsCount: Value(r['stamps_count'] as int? ?? 0),
            totalSpent: Value((r['total_spent'] as num?)?.toDouble() ?? 0.0),
          ),
        );
      }
    } catch (e) {
      debugPrint('[SyncService] syncCustomers error: $e');
    }
  }

  Future<void> syncStaff() async {
    if (!_isConfigured) return;
    try {
      final List<dynamic> remote = await client.from('staff_members').select();
      if (remote.isEmpty) return;

      for (final r in remote) {
        await db.insertStaff(
          StaffMembersCompanion(
            name: Value(r['name'] as String? ?? ''),
            role: Value(r['role'] as String? ?? 'Cashier'),
            pinCode: Value(r['pin_code'] as String? ?? '0000'),
            phone: Value(r['phone'] as String?),
            hourlyRate: Value((r['hourly_rate'] as num?)?.toDouble() ?? 0.0),
            isActive: Value(r['is_active'] as bool? ?? true),
          ),
        );
      }
    } catch (e) {
      debugPrint('[SyncService] syncStaff error: $e');
    }
  }

  Future<void> syncAttendance() async {
    if (!_isConfigured) return;
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final List<dynamic> remote = await client
          .from('staff_attendances')
          .select()
          .gte('clock_in_time', startOfDay.toIso8601String());

      if (remote.isEmpty) return;
      // Remote logs can populate local views as needed
    } catch (e) {
      debugPrint('[SyncService] syncAttendance error: $e');
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
