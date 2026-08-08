import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Tables
// ─────────────────────────────────────────────────────────────────────────────

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get iconCode => text().withDefault(const Constant('e532'))();
  TextColumn get colorHex =>
      text().withDefault(const Constant('#C17F3A'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

class MenuItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  TextColumn get name => text()();
  TextColumn get description =>
      text().withDefault(const Constant(''))();
  RealColumn get basePrice => real()();
  TextColumn get imageUrl => text().nullable()();
  BoolColumn get isAvailable =>
      boolean().withDefault(const Constant(true))();
  TextColumn get preparationStation =>
      text().withDefault(const Constant('kitchen'))();
}

class Ingredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get unit => text()();
  RealColumn get currentStock =>
      real().withDefault(const Constant(0.0))();
  RealColumn get reorderPoint =>
      real().withDefault(const Constant(0.0))();
  RealColumn get costPerUnit =>
      real().withDefault(const Constant(0.0))();
}

class MenuItemIngredients extends Table {
  IntColumn get menuItemId => integer().references(MenuItems, #id)();
  IntColumn get ingredientId =>
      integer().references(Ingredients, #id)();
  RealColumn get quantityRequired => real()();

  @override
  Set<Column> get primaryKey => {menuItemId, ingredientId};
}

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get orderNumber => text()();
  TextColumn get orderType =>
      text().withDefault(const Constant('takeaway'))();
  IntColumn get tableNumber => integer().nullable()();
  TextColumn get status =>
      text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();
  RealColumn get subtotal =>
      real().withDefault(const Constant(0.0))();
  RealColumn get taxAmount =>
      real().withDefault(const Constant(0.0))();
  RealColumn get totalAmount =>
      real().withDefault(const Constant(0.0))();
  TextColumn get paymentMethod => text().nullable()();
  RealColumn get tenderedAmount => real().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();
}

class OrderItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer().references(Orders, #id)();
  IntColumn get menuItemId => integer().references(MenuItems, #id)();
  TextColumn get itemName => text()();
  IntColumn get quantity => integer()();
  RealColumn get unitPrice => real()();
  RealColumn get subtotal => real()();
  TextColumn get modifiers =>
      text().withDefault(const Constant(''))();
}

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get category => text().withDefault(const Constant('opening'))(); // opening | closing | cleaning | maintenance | handover | general
  TextColumn get assignedTo => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('todo'))(); // todo | in_progress | completed
  TextColumn get priority => text().withDefault(const Constant('medium'))(); // low | medium | high
  DateTimeColumn get dueDate => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get completedBy => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text()();
  TextColumn get email => text().nullable()();
  IntColumn get points => integer().withDefault(const Constant(0))();
  TextColumn get tier => text().withDefault(const Constant('Bronze'))(); // Bronze | Silver | Gold | Platinum
  RealColumn get totalSpent => real().withDefault(const Constant(0.0))();
  IntColumn get stampsCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastVisitedAt => dateTime().nullable()();
}

class StaffMembers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get role => text().withDefault(const Constant('Cashier'))(); // Cashier | Barista | Kitchen Staff | Shift Manager | Owner
  TextColumn get pinCode => text().withDefault(const Constant('1234'))();
  TextColumn get phone => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  RealColumn get hourlyRate => real().withDefault(const Constant(10.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class StaffAttendances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get staffId => integer().references(StaffMembers, #id)();
  TextColumn get staffName => text()();
  DateTimeColumn get clockInTime => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get clockOutTime => dateTime().nullable()();
  IntColumn get totalMinutes => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  TextColumn get date => text()(); // YYYY-MM-DD
}

// ─────────────────────────────────────────────────────────────────────────────
// Database
// ─────────────────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [
  Categories,
  MenuItems,
  Ingredients,
  MenuItemIngredients,
  Orders,
  OrderItems,
  Tasks,
  Customers,
  StaffMembers,
  StaffAttendances,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedData();
          await _seedPhase2Data();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(tasks);
            await m.createTable(customers);
            await m.createTable(staffMembers);
            await m.createTable(staffAttendances);
            await _seedPhase2Data();
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'usaha_os');
  }

  // ── Seed Data ──────────────────────────────────────────────────────────────

  Future<void> _seedData() async {
    // Categories
    final hotId = await into(categories).insert(
      CategoriesCompanion.insert(
        name: 'Hot Drinks',
        iconCode: const Value('e5b3'),
        colorHex: const Value('#8D4E1C'),
        sortOrder: const Value(0),
      ),
    );
    final coldId = await into(categories).insert(
      CategoriesCompanion.insert(
        name: 'Cold Drinks',
        iconCode: const Value('e798'),
        colorHex: const Value('#1565C0'),
        sortOrder: const Value(1),
      ),
    );
    final foodId = await into(categories).insert(
      CategoriesCompanion.insert(
        name: 'Food',
        iconCode: const Value('f574'),
        colorHex: const Value('#2E7D32'),
        sortOrder: const Value(2),
      ),
    );
    final pastryId = await into(categories).insert(
      CategoriesCompanion.insert(
        name: 'Pastries',
        iconCode: const Value('e400'),
        colorHex: const Value('#C17F3A'),
        sortOrder: const Value(3),
      ),
    );

    // Menu Items
    final menuSeed = [
      // Hot Drinks
      (c: hotId, n: 'Kopi O', p: 2.50, d: 'Classic black coffee', s: 'bar'),
      (c: hotId, n: 'Teh Tarik', p: 3.00, d: 'Pulled milk tea', s: 'bar'),
      (c: hotId, n: 'Kopi C', p: 3.50, d: 'Coffee with evaporated milk', s: 'bar'),
      (c: hotId, n: 'Cappuccino', p: 8.00, d: 'Espresso with steamed milk foam', s: 'bar'),
      (c: hotId, n: 'Latte', p: 8.50, d: 'Espresso with steamed milk', s: 'bar'),
      (c: hotId, n: 'Americano', p: 7.00, d: 'Espresso with hot water', s: 'bar'),
      (c: hotId, n: 'Milo Panas', p: 4.00, d: 'Hot chocolate malt drink', s: 'bar'),
      (c: hotId, n: 'Horlicks', p: 4.50, d: 'Hot malt milk drink', s: 'bar'),
      // Cold Drinks
      (c: coldId, n: 'Iced Kopi O', p: 3.00, d: 'Iced black coffee', s: 'bar'),
      (c: coldId, n: 'Iced Teh Tarik', p: 3.50, d: 'Iced pulled milk tea', s: 'bar'),
      (c: coldId, n: 'Iced Latte', p: 9.00, d: 'Iced espresso with fresh milk', s: 'bar'),
      (c: coldId, n: 'Milo Ais', p: 4.50, d: 'Iced Milo chocolate malt', s: 'bar'),
      (c: coldId, n: 'Fresh Orange', p: 7.50, d: 'Freshly squeezed orange juice', s: 'bar'),
      (c: coldId, n: 'Lemon Ais', p: 5.00, d: 'Iced lemon with soda', s: 'bar'),
      (c: coldId, n: 'Bandung', p: 4.50, d: 'Rose syrup with evaporated milk', s: 'bar'),
      // Food
      (c: foodId, n: 'Nasi Lemak', p: 8.00, d: 'Coconut rice, sambal, egg & anchovies', s: 'kitchen'),
      (c: foodId, n: 'Roti Bakar', p: 4.50, d: 'Toasted bread with butter & kaya', s: 'kitchen'),
      (c: foodId, n: 'Mee Goreng', p: 9.50, d: 'Fried noodles Malaysian style', s: 'kitchen'),
      (c: foodId, n: 'Half-Boiled Eggs', p: 2.50, d: '2 soft-boiled eggs', s: 'kitchen'),
      (c: foodId, n: 'Sandwich', p: 6.50, d: 'Toasted club sandwich', s: 'kitchen'),
      (c: foodId, n: 'Char Kway Teow', p: 10.00, d: 'Fried flat rice noodles', s: 'kitchen'),
      (c: foodId, n: 'Nasi Goreng', p: 10.00, d: 'Malaysian fried rice', s: 'kitchen'),
      // Pastries
      (c: pastryId, n: 'Croissant', p: 5.50, d: 'Butter croissant', s: 'pastry'),
      (c: pastryId, n: 'Banana Cake', p: 4.50, d: 'Homemade banana cake slice', s: 'pastry'),
      (c: pastryId, n: 'Curry Puff', p: 2.50, d: 'Crispy curry puff', s: 'pastry'),
      (c: pastryId, n: 'Kaya Puff', p: 2.50, d: 'Kaya coconut jam puff', s: 'pastry'),
      (c: pastryId, n: 'Blueberry Muffin', p: 4.00, d: 'Fresh blueberry muffin', s: 'pastry'),
      (c: pastryId, n: 'Egg Tart', p: 3.00, d: 'Portuguese-style egg tart', s: 'pastry'),
    ];

    for (final item in menuSeed) {
      await into(menuItems).insert(
        MenuItemsCompanion.insert(
          categoryId: item.c,
          name: item.n,
          basePrice: item.p,
          description: Value(item.d),
          preparationStation: Value(item.s),
        ),
      );
    }

    // Ingredients
    final ingredientSeed = [
      (n: 'Coffee Beans', u: 'g', s: 2000.0, r: 500.0, c: 0.08),
      (n: 'Espresso Shots', u: 'shots', s: 200.0, r: 50.0, c: 0.80),
      (n: 'Fresh Milk', u: 'ml', s: 5000.0, r: 1000.0, c: 0.006),
      (n: 'Evaporated Milk', u: 'ml', s: 2000.0, r: 500.0, c: 0.004),
      (n: 'Tea Leaves', u: 'g', s: 500.0, r: 100.0, c: 0.05),
      (n: 'Sugar', u: 'g', s: 3000.0, r: 500.0, c: 0.002),
      (n: 'Bread', u: 'pcs', s: 50.0, r: 10.0, c: 0.50),
      (n: 'Eggs', u: 'pcs', s: 100.0, r: 20.0, c: 0.40),
      (n: 'Rice', u: 'g', s: 5000.0, r: 1000.0, c: 0.003),
      (n: 'Orange', u: 'pcs', s: 30.0, r: 10.0, c: 0.80),
      (n: 'Milo Powder', u: 'g', s: 150.0, r: 200.0, c: 0.04),
      (n: 'Butter', u: 'g', s: 500.0, r: 100.0, c: 0.02),
      (n: 'Flour', u: 'g', s: 2000.0, r: 500.0, c: 0.003),
      (n: 'Coconut Milk', u: 'ml', s: 1000.0, r: 200.0, c: 0.007),
      (n: 'Kaya', u: 'g', s: 300.0, r: 100.0, c: 0.03),
    ];

    for (final ing in ingredientSeed) {
      await into(ingredients).insert(
        IngredientsCompanion.insert(
          name: ing.n,
          unit: ing.u,
          currentStock: Value(ing.s),
          reorderPoint: Value(ing.r),
          costPerUnit: Value(ing.c),
        ),
      );
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Category Queries
  // ─────────────────────────────────────────────────────────────────────────

  Stream<List<Category>> watchCategories() =>
      (select(categories)
            ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
          .watch();

  // ─────────────────────────────────────────────────────────────────────────
  // Menu Item Queries
  // ─────────────────────────────────────────────────────────────────────────

  Stream<List<MenuItem>> watchMenuItems({int? categoryId}) {
    final query = select(menuItems)
      ..where((m) => m.isAvailable.equals(true))
      ..orderBy([(m) => OrderingTerm.asc(m.name)]);
    if (categoryId != null) {
      query.where((m) => m.categoryId.equals(categoryId));
    }
    return query.watch();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Ingredient Queries
  // ─────────────────────────────────────────────────────────────────────────

  Stream<List<Ingredient>> watchIngredients() =>
      (select(ingredients)
            ..orderBy([(i) => OrderingTerm.asc(i.name)]))
          .watch();

  Future<List<Ingredient>> getLowStockIngredients() async {
    final all = await select(ingredients).get();
    return all.where((i) => i.currentStock <= i.reorderPoint).toList();
  }

  Future<void> adjustIngredientStock(int id, double delta) async {
    final ing = await (select(ingredients)
          ..where((i) => i.id.equals(id)))
        .getSingleOrNull();
    if (ing == null) return;
    final newStock = (ing.currentStock + delta).clamp(0.0, double.infinity);
    await (update(ingredients)..where((i) => i.id.equals(id))).write(
      IngredientsCompanion(currentStock: Value(newStock)),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Order Queries
  // ─────────────────────────────────────────────────────────────────────────

  Future<int> createOrder(OrdersCompanion order) =>
      into(orders).insert(order);

  Future<void> addOrderItem(OrderItemsCompanion item) =>
      into(orderItems).insert(item);

  Future<Order?> getOrder(int orderId) =>
      (select(orders)..where((o) => o.id.equals(orderId)))
          .getSingleOrNull();

  Future<List<OrderItem>> getOrderItems(int orderId) =>
      (select(orderItems)..where((i) => i.orderId.equals(orderId))).get();

  Stream<List<Order>> watchTodayOrders() {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final end = start.add(const Duration(days: 1));
    return (select(orders)
          ..where((o) =>
              o.createdAt.isBiggerOrEqualValue(start) &
              o.createdAt.isSmallerThanValue(end))
          ..orderBy([(o) => OrderingTerm.desc(o.createdAt)]))
        .watch();
  }

  Future<List<Order>> getTodayOrders() async {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final end = start.add(const Duration(days: 1));
    return (select(orders)
          ..where((o) =>
              o.createdAt.isBiggerOrEqualValue(start) &
              o.createdAt.isSmallerThanValue(end)))
        .get();
  }

  Future<void> completeOrder({
    required int orderId,
    required String paymentMethod,
    required double tendered,
  }) =>
      (update(orders)..where((o) => o.id.equals(orderId))).write(
        OrdersCompanion(
          status: const Value('completed'),
          completedAt: Value(DateTime.now()),
          paymentMethod: Value(paymentMethod),
          tenderedAmount: Value(tendered),
        ),
      );

  Future<void> voidOrder(int orderId) =>
      (update(orders)..where((o) => o.id.equals(orderId))).write(
        const OrdersCompanion(status: Value('voided')),
      );

  // ─────────────────────────────────────────────────────────────────────────
  // Reporting Queries
  // ─────────────────────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> getTodaySummary() async {
    final all = await getTodayOrders();
    final completed =
        all.where((o) => o.status == 'completed').toList();
    final total =
        completed.fold(0.0, (sum, o) => sum + o.totalAmount);
    final avgTicket =
        completed.isEmpty ? 0.0 : total / completed.length;
    return {
      'totalSales': total,
      'orderCount': completed.length,
      'avgTicket': avgTicket,
      'voidCount': all.where((o) => o.status == 'voided').length,
    };
  }

  /// Returns hourly sales map {hour: amount} for today (0..23).
  Future<Map<int, double>> getTodayHourlySales() async {
    final completed = (await getTodayOrders())
        .where((o) => o.status == 'completed');
    final Map<int, double> hourly = {};
    for (final o in completed) {
      final h = o.createdAt.hour;
      hourly[h] = (hourly[h] ?? 0.0) + o.totalAmount;
    }
    return hourly;
  }

  /// Top menu items by quantity sold today.
  Future<List<Map<String, dynamic>>> getTopItemsToday() async {
    final todayOrders = await getTodayOrders();
    final completedIds = todayOrders
        .where((o) => o.status == 'completed')
        .map((o) => o.id)
        .toList();
    if (completedIds.isEmpty) return [];

    final Map<String, int> counts = {};
    for (final id in completedIds) {
      final items = await getOrderItems(id);
      for (final item in items) {
        counts[item.itemName] =
            (counts[item.itemName] ?? 0) + item.quantity;
      }
    }

    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted
        .take(5)
        .map((e) => {'name': e.key, 'count': e.value})
        .toList();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Sync & Reconciliation Methods
  // ─────────────────────────────────────────────────────────────────────────

  Future<List<Category>> getAllCategories() => select(categories).get();

  Future<void> upsertCategory(CategoriesCompanion category) =>
      into(categories).insertOnConflictUpdate(category);

  Future<void> deleteCategoryById(int id) =>
      (delete(categories)..where((c) => c.id.equals(id))).go();

  Future<void> deleteCategoriesNotIn(List<int> ids) =>
      (delete(categories)..where((c) => c.id.isNotIn(ids))).go();

  Future<List<MenuItem>> getAllMenuItems() => select(menuItems).get();

  Future<void> upsertMenuItem(MenuItemsCompanion item) =>
      into(menuItems).insertOnConflictUpdate(item);

  Future<void> deleteMenuItemById(int id) =>
      (delete(menuItems)..where((m) => m.id.equals(id))).go();

  Future<void> deleteMenuItemByName(String name) =>
      (delete(menuItems)..where((m) => m.name.equals(name))).go();

  Future<void> deleteMenuItemsNotIn(List<int> ids) =>
      (delete(menuItems)..where((m) => m.id.isNotIn(ids))).go();

  Future<List<Ingredient>> getAllIngredients() => select(ingredients).get();

  Future<void> upsertIngredient(IngredientsCompanion ing) async {
    final name = ing.name.value;
    final existing = await (select(ingredients)..where((i) => i.name.equals(name))).getSingleOrNull();
    if (existing != null) {
      await (update(ingredients)..where((i) => i.id.equals(existing.id))).write(ing);
    } else {
      await into(ingredients).insert(ing);
    }
  }

  Future<void> deleteIngredientByName(String name) =>
      (delete(ingredients)..where((i) => i.name.equals(name))).go();

  Future<void> deleteIngredientById(int id) =>
      (delete(ingredients)..where((i) => i.id.equals(id))).go();

  Future<Order?> getOrderByOrderNumber(String orderNumber) =>
      (select(orders)..where((o) => o.orderNumber.equals(orderNumber))).getSingleOrNull();

  Future<void> deleteOrderByOrderNumber(String orderNumber) async {
    final order = await getOrderByOrderNumber(orderNumber);
    if (order != null) {
      await deleteOrderById(order.id);
    }
  }

  Future<void> deleteOrderById(int orderId) async {
    await (delete(orderItems)..where((i) => i.orderId.equals(orderId))).go();
    await (delete(orders)..where((o) => o.id.equals(orderId))).go();
  }

  Future<void> deleteOrdersNotIn(List<String> validOrderNumbers, {DateTime? since}) async {
    final query = select(orders);
    if (since != null) {
      query.where((o) => o.createdAt.isBiggerOrEqualValue(since));
    }
    final existingOrders = await query.get();
    for (final o in existingOrders) {
      if (!validOrderNumbers.contains(o.orderNumber)) {
        await deleteOrderById(o.id);
      }
    }
  }

  Future<void> upsertOrderFromRemote(
    OrdersCompanion orderCompanion,
    List<OrderItemsCompanion> itemCompanions,
  ) async {
    final orderNumber = orderCompanion.orderNumber.value;
    final existing = await getOrderByOrderNumber(orderNumber);
    int localOrderId;
    if (existing != null) {
      localOrderId = existing.id;
      await (update(orders)..where((o) => o.id.equals(localOrderId))).write(orderCompanion);
      await (delete(orderItems)..where((i) => i.orderId.equals(localOrderId))).go();
    } else {
      localOrderId = await into(orders).insert(orderCompanion);
    }
    for (final item in itemCompanions) {
      await into(orderItems).insert(item.copyWith(orderId: Value(localOrderId)));
    }
  }

  // ── Phase 2: Seed Data ──────────────────────────────────────────────────────

  Future<void> _seedPhase2Data() async {
    // Seed Tasks
    final existingTasks = await select(tasks).get();
    if (existingTasks.isEmpty) {
      final taskSeeds = [
        // Opening Checklist
        (t: 'Float Count Verification', d: 'Count cash float (RM200) in cash drawer', c: 'opening', p: 'high'),
        (t: 'Espresso Machine Warmup & Flush', d: 'Turn on group heads & steam wand purge', c: 'opening', p: 'high'),
        (t: 'Inspect Fridge & Chiller Temps', d: 'Ensure milk chiller is under 4°C', c: 'opening', p: 'medium'),
        (t: 'Restock Milk, Cups & Lids', d: 'Check front counter stock levels', c: 'opening', p: 'medium'),
        (t: 'Sanitize Workstations & Tables', d: 'Wipe all dining tables and POS counter', c: 'opening', p: 'low'),
        // Closing Checklist
        (t: 'Deep Clean Steam Wand & Group Heads', d: 'Backflush espresso machine with Cafiza', c: 'closing', p: 'high'),
        (t: 'Empty Coffee Puck Bin & Drip Tray', d: 'Wash and sanitize knock box', c: 'closing', p: 'medium'),
        (t: 'Reconcile Cash Drawer & Print Daily Z-Report', d: 'Match cash total against system sales', c: 'closing', p: 'high'),
        (t: 'Discard Expired Pastries & Clear Display', d: 'Log wastage in system', c: 'closing', p: 'medium'),
        (t: 'Lock Doors & Turn Off Signage/AC', d: 'Ensure main breaker & lights are secured', c: 'closing', p: 'high'),
        // Shift Handover
        (t: 'Oat Milk delivery arriving at 10 AM', d: 'Supplier contacted, invoice ready on clipboard', c: 'handover', p: 'medium'),
        (t: 'Grinder 2 calibrated for Dark Roast', d: 'Dose set to 18.5g extraction at 27s', c: 'handover', p: 'low'),
      ];

      for (final s in taskSeeds) {
        await into(tasks).insert(
          TasksCompanion.insert(
            title: s.t,
            description: Value(s.d),
            category: Value(s.c),
            priority: Value(s.p),
            status: const Value('todo'),
          ),
        );
      }
    }

    // Seed Staff Members
    final existingStaff = await select(staffMembers).get();
    if (existingStaff.isEmpty) {
      final staffSeeds = [
        (n: 'Amirul Hakim', r: 'Shift Manager', p: '8888', ph: '012-3456789', hr: 16.0),
        (n: 'Sarah Tan', r: 'Barista', p: '1111', ph: '017-8899112', hr: 12.0),
        (n: 'Haziq Fahmi', r: 'Cashier', p: '2222', ph: '019-2233445', hr: 10.0),
        (n: 'Chef Ramli', r: 'Kitchen Staff', p: '3333', ph: '013-5566778', hr: 14.0),
      ];

      for (final s in staffSeeds) {
        await into(staffMembers).insert(
          StaffMembersCompanion.insert(
            name: s.n,
            role: Value(s.r),
            pinCode: Value(s.p),
            phone: Value(s.ph),
            hourlyRate: Value(s.hr),
            isActive: const Value(true),
          ),
        );
      }
    }

    // Seed Customers (CRM / Loyalty)
    final existingCustomers = await select(customers).get();
    if (existingCustomers.isEmpty) {
      final customerSeeds = [
        (n: 'Ahmad Faizal', ph: '0123456789', e: 'faizal@gmail.com', pts: 120, t: 'Gold', s: 6, sp: 280.0),
        (n: 'Nurul Huda', ph: '0198765432', e: 'huda@yahoo.com', pts: 45, t: 'Silver', s: 4, sp: 95.50),
        (n: 'Tan Wei Lun', ph: '0161122334', e: 'weilun@hotmail.com', pts: 230, t: 'Platinum', s: 9, sp: 450.0),
        (n: 'Siti Aisyah', ph: '0179988776', e: 'aisyah@gmail.com', pts: 15, t: 'Bronze', s: 2, sp: 32.0),
      ];

      for (final c in customerSeeds) {
        await into(customers).insert(
          CustomersCompanion.insert(
            name: c.n,
            phone: c.ph,
            email: Value(c.e),
            points: Value(c.pts),
            tier: Value(c.t),
            stampsCount: Value(c.s),
            totalSpent: Value(c.sp),
          ),
        );
      }
    }
  }

  // ── Phase 2: Tasks Queries ──────────────────────────────────────────────────

  Stream<List<Task>> watchAllTasks() =>
      (select(tasks)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();

  Stream<List<Task>> watchTasksByCategory(String category) =>
      (select(tasks)
        ..where((t) => t.category.equals(category))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .watch();

  Future<int> insertTask(TasksCompanion task) => into(tasks).insert(task);

  Future<void> updateTaskStatus(int id, String status, {String? completedBy}) async {
    await (update(tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        status: Value(status),
        completedAt: Value(status == 'completed' ? DateTime.now() : null),
        completedBy: Value(completedBy),
      ),
    );
  }

  Future<void> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();

  Future<void> upsertTask(TasksCompanion task) async {
    final id = task.id.present ? task.id.value : null;
    if (id != null) {
      final existing = await (select(tasks)..where((t) => t.id.equals(id))).getSingleOrNull();
      if (existing != null) {
        await (update(tasks)..where((t) => t.id.equals(id))).write(task);
        return;
      }
    }
    await into(tasks).insert(task);
  }

  // ── Phase 2: Customers & Loyalty Queries ─────────────────────────────────────

  Stream<List<Customer>> watchAllCustomers() =>
      (select(customers)..orderBy([(c) => OrderingTerm.desc(c.totalSpent)])).watch();

  Future<Customer?> getCustomerById(int id) =>
      (select(customers)..where((c) => c.id.equals(id))).getSingleOrNull();

  Future<Customer?> getCustomerByPhone(String phone) =>
      (select(customers)..where((c) => c.phone.equals(phone))).getSingleOrNull();

  Future<int> insertCustomer(CustomersCompanion customer) =>
      into(customers).insert(customer);

  Future<void> updateCustomer(CustomersCompanion customer) =>
      (update(customers)..where((c) => c.id.equals(customer.id.value))).write(customer);

  Future<void> deleteCustomer(int id) =>
      (delete(customers)..where((c) => c.id.equals(id))).go();

  Future<void> awardCustomerPointsAndStamps(int customerId, double amountSpent) async {
    final customer = await getCustomerById(customerId);
    if (customer == null) return;

    final earnedPoints = amountSpent.floor(); // 1 point per RM1
    final newPoints = customer.points + earnedPoints;
    final newTotalSpent = customer.totalSpent + amountSpent;
    final newStamps = (customer.stampsCount + 1) % 10;

    String newTier = customer.tier;
    if (newTotalSpent >= 400) {
      newTier = 'Platinum';
    } else if (newTotalSpent >= 200) {
      newTier = 'Gold';
    } else if (newTotalSpent >= 80) {
      newTier = 'Silver';
    }

    await (update(customers)..where((c) => c.id.equals(customerId))).write(
      CustomersCompanion(
        points: Value(newPoints),
        stampsCount: Value(newStamps),
        totalSpent: Value(newTotalSpent),
        tier: Value(newTier),
        lastVisitedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<bool> redeemCustomerStamps(int customerId) async {
    final customer = await getCustomerById(customerId);
    if (customer == null || customer.stampsCount < 10) return false;

    await (update(customers)..where((c) => c.id.equals(customerId))).write(
      CustomersCompanion(
        stampsCount: Value(customer.stampsCount - 10),
      ),
    );
    return true;
  }

  Future<void> upsertCustomer(CustomersCompanion customer) async {
    final phone = customer.phone.value;
    final existing = await getCustomerByPhone(phone);
    if (existing != null) {
      await (update(customers)..where((c) => c.id.equals(existing.id))).write(customer);
    } else {
      await into(customers).insert(customer);
    }
  }

  // ── Phase 2: Staff & Attendance Queries ──────────────────────────────────────

  Stream<List<StaffMember>> watchAllStaff() =>
      (select(staffMembers)..orderBy([(s) => OrderingTerm.asc(s.name)])).watch();

  Future<StaffMember?> getStaffById(int id) =>
      (select(staffMembers)..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<StaffMember?> verifyStaffPin(String pin) =>
      (select(staffMembers)..where((s) => s.pinCode.equals(pin) & s.isActive.equals(true)))
          .getSingleOrNull();

  Future<int> insertStaff(StaffMembersCompanion staff) =>
      into(staffMembers).insert(staff);

  Future<void> updateStaff(StaffMembersCompanion staff) =>
      (update(staffMembers)..where((s) => s.id.equals(staff.id.value))).write(staff);

  Future<void> deleteStaff(int id) =>
      (delete(staffMembers)..where((s) => s.id.equals(id))).go();

  Future<void> upsertStaff(StaffMembersCompanion staff) async {
    final id = staff.id.present ? staff.id.value : null;
    if (id != null) {
      final existing = await getStaffById(id);
      if (existing != null) {
        await (update(staffMembers)..where((s) => s.id.equals(id))).write(staff);
        return;
      }
    }
    await into(staffMembers).insert(staff);
  }

  Stream<List<StaffAttendance>> watchTodayAttendance() {
    final now = DateTime.now();
    final todayStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    return (select(staffAttendances)
          ..where((a) => a.date.equals(todayStr))
          ..orderBy([(a) => OrderingTerm.desc(a.clockInTime)]))
        .watch();
  }

  Future<StaffAttendance?> getActiveAttendance(int staffId) {
    final now = DateTime.now();
    final todayStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    return (select(staffAttendances)
          ..where((a) => a.staffId.equals(staffId) & a.date.equals(todayStr) & a.clockOutTime.isNull()))
        .getSingleOrNull();
  }

  Future<int> clockInStaff(int staffId, String staffName, {String? notes}) {
    final now = DateTime.now();
    final todayStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    return into(staffAttendances).insert(
      StaffAttendancesCompanion.insert(
        staffId: staffId,
        staffName: staffName,
        clockInTime: Value(now),
        notes: Value(notes ?? ''),
        date: todayStr,
      ),
    );
  }

  Future<void> clockOutStaff(int attendanceId) async {
    final attendance = await (select(staffAttendances)..where((a) => a.id.equals(attendanceId))).getSingleOrNull();
    if (attendance == null) return;
    final now = DateTime.now();
    final duration = now.difference(attendance.clockInTime).inMinutes;

    await (update(staffAttendances)..where((a) => a.id.equals(attendanceId))).write(
      StaffAttendancesCompanion(
        clockOutTime: Value(now),
        totalMinutes: Value(duration),
      ),
    );
  }

  Future<void> upsertAttendance(StaffAttendancesCompanion attendance) async {
    final id = attendance.id.present ? attendance.id.value : null;
    if (id != null) {
      final existing = await (select(staffAttendances)..where((a) => a.id.equals(id))).getSingleOrNull();
      if (existing != null) {
        await (update(staffAttendances)..where((a) => a.id.equals(id))).write(attendance);
        return;
      }
    }
    await into(staffAttendances).insert(attendance);
  }

  // ── Phase 2: KDS Queries ────────────────────────────────────────────────────

  Stream<List<Order>> watchActiveKdsOrders() {
    return (select(orders)
          ..where((o) => o.status.isIn(['pending', 'in_progress', 'ready']))
          ..orderBy([(o) => OrderingTerm.asc(o.createdAt)]))
        .watch();
  }

  Future<void> updateOrderStatus(int orderId, String status) async {
    await (update(orders)..where((o) => o.id.equals(orderId))).write(
      OrdersCompanion(
        status: Value(status),
        completedAt: Value(status == 'completed' ? DateTime.now() : null),
      ),
    );
  }
}


