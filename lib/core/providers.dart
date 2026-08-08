import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/database/app_database.dart';
import '../data/models/cart_item.dart';
import '../data/sync/sync_service.dart';
import '../features/pos/cart_notifier.dart';

// ── Infrastructure ────────────────────────────────────────────────────────────

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(
    db: ref.watch(databaseProvider),
    client: ref.watch(supabaseClientProvider),
  );
  service.initRealtime();
  service.pullAllFromSupabase();
  ref.onDispose(service.dispose);
  return service;
});

// ── Menu ──────────────────────────────────────────────────────────────────────

/// All categories, ordered by sortOrder.
final categoriesProvider = StreamProvider<List<Category>>((ref) {
  return ref.watch(databaseProvider).watchCategories();
});

/// Currently selected category ID (null = show all).
final selectedCategoryProvider = StateProvider<int?>((ref) => null);

/// Menu items filtered by selected category.
final menuItemsProvider = StreamProvider<List<MenuItem>>((ref) {
  final categoryId = ref.watch(selectedCategoryProvider);
  return ref.watch(databaseProvider).watchMenuItems(categoryId: categoryId);
});

// ── Cart ──────────────────────────────────────────────────────────────────────

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

/// Current order type for the active cart.
final orderTypeProvider = StateProvider<String>((ref) => 'takeaway');

/// Table number for dine-in orders.
final tableNumberProvider = StateProvider<int?>((ref) => null);

// ── Orders ────────────────────────────────────────────────────────────────────

final todayOrdersProvider = StreamProvider<List<Order>>((ref) {
  return ref.watch(databaseProvider).watchTodayOrders();
});

// ── Inventory ─────────────────────────────────────────────────────────────────

final ingredientsProvider = StreamProvider<List<Ingredient>>((ref) {
  return ref.watch(databaseProvider).watchIngredients();
});

// ── Reports ───────────────────────────────────────────────────────────────────

final todaySummaryProvider = FutureProvider<Map<String, dynamic>>((ref) {
  // Re-run whenever today's orders change.
  ref.watch(todayOrdersProvider);
  return ref.watch(databaseProvider).getTodaySummary();
});

final hourlySalesProvider =
    FutureProvider<Map<int, double>>((ref) {
  ref.watch(todayOrdersProvider);
  return ref.watch(databaseProvider).getTodayHourlySales();
});

final topItemsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) {
  ref.watch(todayOrdersProvider);
  return ref.watch(databaseProvider).getTopItemsToday();
});
