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
  service.startContinuousSync();
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

/// All menu items including unavailable (for management/toggle screen)
final allMenuItemsWithAvailabilityProvider = StreamProvider<List<MenuItem>>((ref) {
  return ref.watch(databaseProvider).watchAllMenuItemsIncludingUnavailable();
});

// ── Add-ons ───────────────────────────────────────────────────────────────────

/// All add-ons
final allAddonsProvider = StreamProvider<List<MenuAddon>>((ref) {
  return ref.watch(databaseProvider).watchAllAddons();
});

/// Add-ons for a specific menu item
final addonsForItemProvider = FutureProvider.family<List<MenuAddon>, int>((ref, menuItemId) {
  return ref.watch(databaseProvider).getAddonsForItem(menuItemId);
});

// ── Combo Sets ────────────────────────────────────────────────────────────────

/// All available combo sets
final allComboSetsProvider = StreamProvider<List<ComboSet>>((ref) {
  return ref.watch(databaseProvider).watchAllComboSets();
});

/// Combo items with details
final comboItemsProvider = FutureProvider.family<List<Map<String, dynamic>>, int>((ref, comboId) {
  return ref.watch(databaseProvider).getComboItemsWithDetails(comboId);
});

// ── Cart & Customer Attachment ────────────────────────────────────────────────


final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

/// Current order type for the active cart.
final orderTypeProvider = StateProvider<String>((ref) => 'takeaway');

/// Table number for dine-in orders.
final tableNumberProvider = StateProvider<int?>((ref) => null);

/// Currently selected customer for CRM/Loyalty points attached to the cart
final selectedCustomerProvider = StateProvider<Customer?>((ref) => null);

// ── Orders & KDS (Phase 2) ────────────────────────────────────────────────────

final todayOrdersProvider = StreamProvider<List<Order>>((ref) {
  return ref.watch(databaseProvider).watchTodayOrders();
});

final allOrdersProvider = StreamProvider<List<Order>>((ref) {
  return ref.watch(databaseProvider).watchAllOrders();
});

final activeKdsOrdersProvider = StreamProvider<List<Order>>((ref) {
  return ref.watch(databaseProvider).watchActiveKdsOrders();
});

// ── Operations & Tasks (Phase 2) ──────────────────────────────────────────────

final allTasksProvider = StreamProvider<List<Task>>((ref) {
  return ref.watch(databaseProvider).watchAllTasks();
});

// ── Staff & Attendance (Phase 2) ──────────────────────────────────────────────

final allStaffProvider = StreamProvider<List<StaffMember>>((ref) {
  return ref.watch(databaseProvider).watchAllStaff();
});

final todayAttendanceProvider = StreamProvider<List<StaffAttendance>>((ref) {
  return ref.watch(databaseProvider).watchTodayAttendance();
});

// ── Customers & CRM (Phase 2) ─────────────────────────────────────────────────

final allCustomersProvider = StreamProvider<List<Customer>>((ref) {
  return ref.watch(databaseProvider).watchAllCustomers();
});

// ── Inventory ─────────────────────────────────────────────────────────────────

final ingredientsProvider = StreamProvider<List<Ingredient>>((ref) {
  return ref.watch(databaseProvider).watchIngredients();
});

// ── Phase 3: Suppliers & Purchase Orders ──────────────────────────────────────

final allSuppliersProvider = StreamProvider<List<Supplier>>((ref) {
  return ref.watch(databaseProvider).watchAllSuppliers();
});

final allPurchaseOrdersProvider = StreamProvider<List<PurchaseOrder>>((ref) {
  return ref.watch(databaseProvider).watchAllPurchaseOrders();
});

final purchaseOrderItemsProvider =
    StreamProvider.family<List<PurchaseOrderItem>, int>((ref, poId) {
      return ref.watch(databaseProvider).watchPurchaseOrderItems(poId);
    });

// ── Phase 3: Stock Audits (Stock Take) ────────────────────────────────────────

final allStockAuditsProvider = StreamProvider<List<StockAudit>>((ref) {
  return ref.watch(databaseProvider).watchAllStockAudits();
});

// ── Phase 3: Expenses & Petty Cash ────────────────────────────────────────────

final allExpensesProvider = StreamProvider<List<Expense>>((ref) {
  return ref.watch(databaseProvider).watchAllExpenses();
});

final todayExpensesProvider = StreamProvider<List<Expense>>((ref) {
  return ref.watch(databaseProvider).watchTodayExpenses();
});

final todayTotalExpensesProvider = FutureProvider<double>((ref) {
  ref.watch(todayExpensesProvider);
  return ref.watch(databaseProvider).getTodayTotalExpenses();
});

final cashDrawerLogsProvider = StreamProvider<List<CashDrawerLog>>((ref) {
  return ref.watch(databaseProvider).watchCashDrawerLogs();
});

final todayCashDrawerBalanceProvider = FutureProvider<double>((ref) {
  ref.watch(todayOrdersProvider);
  ref.watch(todayExpensesProvider);
  ref.watch(cashDrawerLogsProvider);
  return ref.watch(databaseProvider).getTodayCashDrawerBalance();
});

// ── Phase 3: SST Tax & Business Settings ──────────────────────────────────────

class SstSettings {
  final bool isEnabled;
  final double rate; // e.g. 0.06 for 6%
  final String sstNumber;

  const SstSettings({
    this.isEnabled = true,
    this.rate = 0.06,
    this.sstNumber = 'W10-2308-32000000',
  });

  SstSettings copyWith({bool? isEnabled, double? rate, String? sstNumber}) {
    return SstSettings(
      isEnabled: isEnabled ?? this.isEnabled,
      rate: rate ?? this.rate,
      sstNumber: sstNumber ?? this.sstNumber,
    );
  }
}

class SstSettingsNotifier extends StateNotifier<SstSettings> {
  SstSettingsNotifier() : super(const SstSettings());

  void toggleSst(bool enabled) => state = state.copyWith(isEnabled: enabled);
  void updateRate(double rate) => state = state.copyWith(rate: rate);
  void updateSstNumber(String number) =>
      state = state.copyWith(sstNumber: number);
}

final sstSettingsProvider =
    StateNotifierProvider<SstSettingsNotifier, SstSettings>((ref) {
      return SstSettingsNotifier();
    });

// ── Reports ───────────────────────────────────────────────────────────────────

final todaySummaryProvider = FutureProvider<Map<String, dynamic>>((ref) {
  // Re-run whenever today's orders change.
  ref.watch(todayOrdersProvider);
  return ref.watch(databaseProvider).getTodaySummary();
});

final hourlySalesProvider = FutureProvider<Map<int, double>>((ref) {
  ref.watch(todayOrdersProvider);
  return ref.watch(databaseProvider).getTodayHourlySales();
});

final topItemsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) {
  ref.watch(todayOrdersProvider);
  return ref.watch(databaseProvider).getTopItemsToday();
});

// ── Phase 4: Multi-Outlet & Stock Transfers ──────────────────────────────────

final allOutletsProvider = StreamProvider<List<Outlet>>((ref) {
  return ref.watch(databaseProvider).watchAllOutlets();
});

final activeOutletProvider = StateProvider<Outlet?>((ref) => null);

final allStockTransfersProvider = StreamProvider<List<StockTransfer>>((ref) {
  return ref.watch(databaseProvider).watchAllStockTransfers();
});

// ── Phase 4: Delivery Platforms (GrabFood / Foodpanda / ShopeeFood) ───────────

final allDeliveryOrdersProvider = StreamProvider<List<DeliveryOrder>>((ref) {
  return ref.watch(databaseProvider).watchAllDeliveryOrders();
});

// ── Phase 4: Advanced Business Analytics ─────────────────────────────────────

final itemCogsAnalysisProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) {
  ref.watch(menuItemsProvider);
  ref.watch(ingredientsProvider);
  return ref.watch(databaseProvider).getItemCogsAnalysis();
});

final hourlyRushHeatmapProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) {
  ref.watch(todayOrdersProvider);
  return ref.watch(databaseProvider).getHourlyRushHeatmap();
});

final staffLeaderboardProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) {
  ref.watch(todayOrdersProvider);
  ref.watch(allStaffProvider);
  return ref.watch(databaseProvider).getStaffLeaderboard();
});

final pnlSummaryProvider = FutureProvider<Map<String, dynamic>>((ref) {
  ref.watch(todayOrdersProvider);
  ref.watch(todayExpensesProvider);
  return ref.watch(databaseProvider).getProfitAndLossSummary();
});
