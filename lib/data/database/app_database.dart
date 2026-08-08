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
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedData();
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
}

