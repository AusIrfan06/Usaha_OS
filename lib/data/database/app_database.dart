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
// Phase 2 Tables: Tasks, Customers (CRM/Loyalty), Staff & Attendance
// ─────────────────────────────────────────────────────────────────────────────

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
// Phase 3 Tables: Suppliers, Purchase Orders, Stock Audits, Expenses, Petty Cash
// ─────────────────────────────────────────────────────────────────────────────

class Suppliers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get contactPerson => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get paymentTerms => text().withDefault(const Constant('COD'))(); // COD | 14_days | 30_days
  TextColumn get category => text().withDefault(const Constant('Coffee Beans'))(); // Coffee Beans | Dairy & Milk | Syrups | Packaging | Fresh Food | Equipment
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class PurchaseOrders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get poNumber => text()();
  IntColumn get supplierId => integer().references(Suppliers, #id)();
  TextColumn get supplierName => text()();
  TextColumn get status => text().withDefault(const Constant('draft'))(); // draft | ordered | received | cancelled
  RealColumn get totalAmount => real().withDefault(const Constant(0.0))();
  DateTimeColumn get orderDate => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get expectedDate => dateTime().nullable()();
  DateTimeColumn get receivedDate => dateTime().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();
}

class PurchaseOrderItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get poId => integer().references(PurchaseOrders, #id)();
  IntColumn get ingredientId => integer().references(Ingredients, #id)();
  TextColumn get ingredientName => text()();
  TextColumn get unit => text().withDefault(const Constant('unit'))();
  RealColumn get quantityOrdered => real().withDefault(const Constant(1.0))();
  RealColumn get quantityReceived => real().withDefault(const Constant(0.0))();
  RealColumn get unitCost => real().withDefault(const Constant(0.0))();
  RealColumn get subtotal => real().withDefault(const Constant(0.0))();
}

class StockAudits extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ingredientId => integer().references(Ingredients, #id)();
  TextColumn get ingredientName => text()();
  TextColumn get unit => text().withDefault(const Constant('unit'))();
  RealColumn get expectedStock => real().withDefault(const Constant(0.0))();
  RealColumn get actualStock => real().withDefault(const Constant(0.0))();
  RealColumn get varianceQuantity => real().withDefault(const Constant(0.0))(); // actual - expected
  RealColumn get varianceValue => real().withDefault(const Constant(0.0))(); // varianceQuantity * costPerUnit
  TextColumn get reason => text().withDefault(const Constant('Routine Check'))(); // Routine Check | Wastage | Expiry | Spillage | Staff Meal | Discrepancy
  TextColumn get auditedBy => text().withDefault(const Constant('Shift Manager'))();
  DateTimeColumn get auditedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get notes => text().withDefault(const Constant(''))();
}

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text().withDefault(const Constant('Petty Cash'))(); // Petty Cash | Ingredients | Utilities | Maintenance | Staff Wages | Marketing | Miscellaneous
  RealColumn get amount => real().withDefault(const Constant(0.0))();
  TextColumn get paymentMethod => text().withDefault(const Constant('cash'))(); // cash | duitnow | bank_transfer
  TextColumn get recipient => text().withDefault(const Constant(''))(); // Supplier, Kedai Runcit, TNB, etc.
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get receiptNumber => text().nullable()();
  TextColumn get recordedBy => text().withDefault(const Constant('Staff'))();
  DateTimeColumn get expenseDate => dateTime().withDefault(currentDateAndTime)();
}

class CashDrawerLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()(); // float_in | cash_in | cash_out | drop | audit
  RealColumn get amount => real().withDefault(const Constant(0.0))();
  TextColumn get reason => text().withDefault(const Constant(''))();
  TextColumn get recordedBy => text().withDefault(const Constant('Staff'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
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
  Suppliers,
  PurchaseOrders,
  PurchaseOrderItems,
  StockAudits,
  Expenses,
  CashDrawerLogs,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedData();
          await _seedPhase2Data();
          await _seedPhase3Data();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(tasks);
            await m.createTable(customers);
            await m.createTable(staffMembers);
            await m.createTable(staffAttendances);
            await _seedPhase2Data();
          }
          if (from < 3) {
            await m.createTable(suppliers);
            await m.createTable(purchaseOrders);
            await m.createTable(purchaseOrderItems);
            await m.createTable(stockAudits);
            await m.createTable(expenses);
            await m.createTable(cashDrawerLogs);
            await _seedPhase3Data();
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'usaha_os');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Seed Data
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _seedData() async {
    // Categories
    final hotId = await into(categories).insert(
      CategoriesCompanion.insert(
        name: 'Hot Drinks',
        iconCode: const Value('e532'),
        colorHex: const Value('#C17F3A'),
        sortOrder: const Value(0),
      ),
    );
    final coldId = await into(categories).insert(
      CategoriesCompanion.insert(
        name: 'Cold Drinks',
        iconCode: const Value('e30e'),
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
      (c: hotId, n: 'Kopi O', p: 2.50, d: 'Classic black coffee', s: 'bar'),
      (c: hotId, n: 'Teh Tarik', p: 3.00, d: 'Pulled milk tea', s: 'bar'),
      (c: hotId, n: 'Kopi C', p: 3.50, d: 'Coffee with evaporated milk', s: 'bar'),
      (c: hotId, n: 'Cappuccino', p: 8.00, d: 'Espresso with steamed milk foam', s: 'bar'),
      (c: hotId, n: 'Latte', p: 8.50, d: 'Espresso with steamed milk', s: 'bar'),
      (c: hotId, n: 'Americano', p: 7.00, d: 'Espresso with hot water', s: 'bar'),
      (c: hotId, n: 'Milo Panas', p: 4.00, d: 'Hot chocolate malt drink', s: 'bar'),
      (c: hotId, n: 'Horlicks', p: 4.50, d: 'Hot malt milk drink', s: 'bar'),
      (c: coldId, n: 'Iced Kopi O', p: 3.00, d: 'Iced black coffee', s: 'bar'),
      (c: coldId, n: 'Iced Teh Tarik', p: 3.50, d: 'Iced pulled milk tea', s: 'bar'),
      (c: coldId, n: 'Iced Latte', p: 9.00, d: 'Iced espresso with fresh milk', s: 'bar'),
      (c: coldId, n: 'Milo Ais', p: 4.50, d: 'Iced Milo chocolate malt', s: 'bar'),
      (c: coldId, n: 'Fresh Orange', p: 7.50, d: 'Freshly squeezed orange juice', s: 'bar'),
      (c: coldId, n: 'Lemon Ais', p: 5.00, d: 'Iced lemon with soda', s: 'bar'),
      (c: coldId, n: 'Bandung', p: 4.50, d: 'Rose syrup with evaporated milk', s: 'bar'),
      (c: foodId, n: 'Nasi Lemak', p: 8.00, d: 'Coconut rice, sambal, egg & anchovies', s: 'kitchen'),
      (c: foodId, n: 'Roti Bakar', p: 4.50, d: 'Toasted bread with butter & kaya', s: 'kitchen'),
      (c: foodId, n: 'Mee Goreng', p: 9.50, d: 'Fried noodles Malaysian style', s: 'kitchen'),
      (c: foodId, n: 'Half-Boiled Eggs', p: 2.50, d: '2 soft-boiled eggs', s: 'kitchen'),
      (c: foodId, n: 'Sandwich', p: 6.50, d: 'Toasted club sandwich', s: 'kitchen'),
      (c: foodId, n: 'Char Kway Teow', p: 10.00, d: 'Fried flat rice noodles', s: 'kitchen'),
      (c: foodId, n: 'Nasi Goreng', p: 10.00, d: 'Malaysian fried rice', s: 'kitchen'),
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

  // ── Phase 2: Seed Data ──────────────────────────────────────────────────────

  Future<void> _seedPhase2Data() async {
    // Seed Tasks
    final existingTasks = await select(tasks).get();
    if (existingTasks.isEmpty) {
      final taskSeeds = [
        (t: 'Float Count Verification', d: 'Count cash float (RM200) in cash drawer', c: 'opening', p: 'high'),
        (t: 'Espresso Machine Warmup & Flush', d: 'Turn on group heads & steam wand purge', c: 'opening', p: 'high'),
        (t: 'Inspect Fridge & Chiller Temps', d: 'Ensure milk chiller is under 4°C', c: 'opening', p: 'medium'),
        (t: 'Restock Milk, Cups & Lids', d: 'Check front counter stock levels', c: 'opening', p: 'medium'),
        (t: 'Sanitize Workstations & Tables', d: 'Wipe all dining tables and POS counter', c: 'opening', p: 'low'),
        (t: 'Deep Clean Steam Wand & Group Heads', d: 'Backflush espresso machine with Cafiza', c: 'closing', p: 'high'),
        (t: 'Empty Coffee Puck Bin & Drip Tray', d: 'Wash and sanitize knock box', c: 'closing', p: 'medium'),
        (t: 'Reconcile Cash Drawer & Print Daily Z-Report', d: 'Match cash total against system sales', c: 'closing', p: 'high'),
        (t: 'Discard Expired Pastries & Clear Display', d: 'Log wastage in system', c: 'closing', p: 'medium'),
        (t: 'Lock Doors & Turn Off Signage/AC', d: 'Ensure main breaker & lights are secured', c: 'closing', p: 'high'),
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
        (n: 'Nurul Huda', r: 'Barista', p: '1234', ph: '017-9876543', hr: 12.0),
        (n: 'Mohd Faiz', r: 'Kitchen Staff', p: '2345', ph: '013-1122334', hr: 11.5),
        (n: 'Siti Sarah', r: 'Cashier', p: '3456', ph: '019-4455667', hr: 10.0),
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

    // Seed Customers (CRM)
    final existingCustomers = await select(customers).get();
    if (existingCustomers.isEmpty) {
      final customerSeeds = [
        (n: 'Dato Adam Haris', p: '012-2345678', e: 'adam@haris.my', pts: 420, t: 'Gold', s: 7, sp: 480.50),
        (n: 'Farhan Azman', p: '019-8765432', e: 'farhan.a@gmail.com', pts: 150, t: 'Silver', s: 3, sp: 165.00),
        (n: 'Aisyah Razak', p: '013-5566778', e: 'aisyah_r@yahoo.com', pts: 60, t: 'Bronze', s: 2, sp: 65.00),
        (n: 'Khairul Anwar', p: '017-2233445', e: 'khairul@pos.com', pts: 890, t: 'Platinum', s: 8, sp: 1120.00),
      ];

      for (final c in customerSeeds) {
        await into(customers).insert(
          CustomersCompanion.insert(
            name: c.n,
            phone: c.p,
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

  // ── Phase 3: Seed Data ──────────────────────────────────────────────────────

  Future<void> _seedPhase3Data() async {
    // Seed Suppliers
    final existingSuppliers = await select(suppliers).get();
    if (existingSuppliers.isEmpty) {
      final s1 = await into(suppliers).insert(
        SuppliersCompanion.insert(
          name: 'Nusantara Roastery Sdn Bhd',
          contactPerson: const Value('En. Zainal Abidin'),
          phone: const Value('03-78901234'),
          email: const Value('order@nusantararoastery.my'),
          address: const Value('No. 12, Jalan Kilang 51/205, Petaling Jaya, Selangor'),
          paymentTerms: const Value('30_days'),
          category: const Value('Coffee Beans'),
          isActive: const Value(true),
        ),
      );

      await into(suppliers).insert(
        SuppliersCompanion.insert(
          name: 'Farm Fresh Milk Supply',
          contactPerson: const Value('Pn. Laili'),
          phone: const Value('016-5544332'),
          email: const Value('sales@farmfreshdairy.my'),
          address: const Value('Ladang Farm Fresh, UPM Serdang, Selangor'),
          paymentTerms: const Value('COD'),
          category: const Value('Dairy & Milk'),
          isActive: const Value(true),
        ),
      );

      await into(suppliers).insert(
        SuppliersCompanion.insert(
          name: 'EcoPack Packaging Industries',
          contactPerson: const Value('Mr. Kevin Tan'),
          phone: const Value('03-88992211'),
          email: const Value('orders@ecopack.com.my'),
          address: const Value('Kawasan Perindustrian Balakong, Cheras'),
          paymentTerms: const Value('14_days'),
          category: const Value('Packaging'),
          isActive: const Value(true),
        ),
      );

      // Seed Sample Purchase Order
      final poId = await into(purchaseOrders).insert(
        PurchaseOrdersCompanion.insert(
          poNumber: 'PO-20260808-001',
          supplierId: s1,
          supplierName: 'Nusantara Roastery Sdn Bhd',
          status: const Value('ordered'),
          totalAmount: const Value(360.00),
          orderDate: Value(DateTime.now().subtract(const Duration(days: 1))),
          expectedDate: Value(DateTime.now().add(const Duration(days: 1))),
          notes: const Value('Bekalan biji kopi Arabica House Blend 5kg'),
        ),
      );

      await into(purchaseOrderItems).insert(
        PurchaseOrderItemsCompanion.insert(
          poId: poId,
          ingredientId: 1, // Coffee Beans
          ingredientName: 'Coffee Beans',
          unit: const Value('g'),
          quantityOrdered: const Value(4500.0),
          quantityReceived: const Value(0.0),
          unitCost: const Value(0.08),
          subtotal: const Value(360.00),
        ),
      );
    }

    // Seed Sample Petty Cash Expenses & Cash Drawer
    final existingExpenses = await select(expenses).get();
    if (existingExpenses.isEmpty) {
      await into(expenses).insert(
        ExpensesCompanion.insert(
          category: const Value('Petty Cash'),
          amount: const Value(25.00),
          paymentMethod: const Value('cash'),
          recipient: const Value('Kilang Ais Batu Bersih'),
          description: const Value('Beli 5 beg ais kiub kecemasan'),
          receiptNumber: const Value('ICE-9821'),
          recordedBy: const Value('Amirul Hakim'),
          expenseDate: Value(DateTime.now().subtract(const Duration(hours: 3))),
        ),
      );

      await into(expenses).insert(
        ExpensesCompanion.insert(
          category: const Value('Ingredients'),
          amount: const Value(48.50),
          paymentMethod: const Value('cash'),
          recipient: const Value('Pasar Mini Seri Kembangan'),
          description: const Value('Beli 6 botol Susu Segar & Telur Gred A'),
          receiptNumber: const Value('PM-44321'),
          recordedBy: const Value('Nurul Huda'),
          expenseDate: Value(DateTime.now().subtract(const Duration(hours: 1))),
        ),
      );

      await into(cashDrawerLogs).insert(
        CashDrawerLogsCompanion.insert(
          type: 'float_in',
          amount: const Value(200.00),
          reason: const Value('Wang apungan permulaan syif pagi (Float In)'),
          recordedBy: const Value('Amirul Hakim'),
          createdAt: Value(DateTime.now().subtract(const Duration(hours: 6))),
        ),
      );
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Queries & Mutations
  // ─────────────────────────────────────────────────────────────────────────

  Stream<List<Category>> watchAllCategories() =>
      (select(categories)..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
          .watch();

  Stream<List<Category>> watchCategories() => watchAllCategories();

  Stream<List<MenuItem>> watchMenuItems({int? categoryId}) {
    final query = select(menuItems)..where((m) => m.isAvailable.equals(true));
    if (categoryId != null) {
      query.where((m) => m.categoryId.equals(categoryId));
    }
    return query.watch();
  }

  Stream<List<MenuItem>> watchMenuItemsByCategory(int categoryId) =>
      (select(menuItems)
            ..where((m) =>
                m.categoryId.equals(categoryId) & m.isAvailable.equals(true)))
          .watch();

  Stream<List<MenuItem>> watchAllMenuItems() =>
      (select(menuItems)..where((m) => m.isAvailable.equals(true))).watch();

  Stream<List<Ingredient>> watchAllIngredients() =>
      select(ingredients).watch();

  Stream<List<Ingredient>> watchIngredients() => watchAllIngredients();

  Future<List<Ingredient>> getAllIngredients() => select(ingredients).get();

  Future<Ingredient?> getIngredientById(int id) =>
      (select(ingredients)..where((i) => i.id.equals(id))).getSingleOrNull();

  Future<void> updateIngredientStock(int ingredientId, double newStock) =>
      (update(ingredients)..where((i) => i.id.equals(ingredientId)))
          .write(IngredientsCompanion(currentStock: Value(newStock)));

  // ── Orders ─────────────────────────────────────────────────────────────────

  Stream<List<Order>> watchTodayOrders() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    return (select(orders)
          ..where((o) => o.createdAt.isBiggerOrEqualValue(startOfDay))
          ..orderBy([(o) => OrderingTerm.desc(o.createdAt)]))
        .watch();
  }

  Stream<List<Order>> watchPendingOrders() =>
      (select(orders)
            ..where((o) => o.status.equals('pending'))
            ..orderBy([(o) => OrderingTerm.desc(o.createdAt)]))
          .watch();

  Future<List<Order>> getTodayOrders() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    return (select(orders)
          ..where((o) => o.createdAt.isBiggerOrEqualValue(startOfDay))
          ..orderBy([(o) => OrderingTerm.desc(o.createdAt)]))
        .get();
  }

  Future<Order?> getOrder(int id) =>
      (select(orders)..where((o) => o.id.equals(id))).getSingleOrNull();

  Future<List<OrderItem>> getOrderItems(int orderId) =>
      (select(orderItems)..where((i) => i.orderId.equals(orderId))).get();

  Stream<List<OrderItem>> watchOrderItems(int orderId) =>
      (select(orderItems)..where((i) => i.orderId.equals(orderId))).watch();

  Future<int> createOrder(OrdersCompanion order) => into(orders).insert(order);

  Future<int> addOrderItem(OrderItemsCompanion item) => into(orderItems).insert(item);

  Future<int> insertOrder(
    OrdersCompanion order,
    List<OrderItemsCompanion> items,
  ) {
    return transaction(() async {
      final orderId = await into(orders).insert(order);
      for (final item in items) {
        await into(orderItems).insert(item.copyWith(orderId: Value(orderId)));
      }
      return orderId;
    });
  }

  Future<void> completeOrder({
    required int orderId,
    required String paymentMethod,
    double? tendered,
    double? tenderedAmount,
  }) {
    final amount = tendered ?? tenderedAmount;
    return transaction(() async {
      await (update(orders)..where((o) => o.id.equals(orderId))).write(
        OrdersCompanion(
          status: const Value('completed'),
          completedAt: Value(DateTime.now()),
          paymentMethod: Value(paymentMethod),
          tenderedAmount: Value(amount),
        ),
      );

      final items = await getOrderItems(orderId);
      for (final item in items) {
        final links = await (select(menuItemIngredients)
              ..where((l) => l.menuItemId.equals(item.menuItemId)))
            .get();
        for (final link in links) {
          final deduct = link.quantityRequired * item.quantity;
          final ing = await (select(ingredients)
                ..where((i) => i.id.equals(link.ingredientId)))
              .getSingleOrNull();
          if (ing != null) {
            final newStock = (ing.currentStock - deduct).clamp(0.0, 99999.0);
            await (update(ingredients)..where((i) => i.id.equals(ing.id)))
                .write(IngredientsCompanion(currentStock: Value(newStock)));
          }
        }
      }
    });
  }

  Future<void> voidOrder(int orderId) {
    return transaction(() async {
      await (update(orders)..where((o) => o.id.equals(orderId))).write(
        const OrdersCompanion(status: Value('voided')),
      );
    });
  }

  // ── Dashboard / Reports Queries ───────────────────────────────────────────

  Future<Map<String, dynamic>> getTodaySummary() async {
    final all = await getTodayOrders();
    final completed = all.where((o) => o.status == 'completed').toList();
    final double totalSales =
        completed.fold(0.0, (sum, o) => sum + o.totalAmount);
    final double avgTicket =
        completed.isNotEmpty ? totalSales / completed.length : 0.0;

    return {
      'totalSales': totalSales,
      'orderCount': completed.length,
      'avgTicket': avgTicket,
      'voidCount': all.where((o) => o.status == 'voided').length,
    };
  }

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

  // ── Sync & Categories / Items Methods ──────────────────────────────────────

  Future<List<Category>> getAllCategories() => select(categories).get();

  Future<Category?> getCategoryByName(String name) =>
      (select(categories)..where((c) => c.name.equals(name))).getSingleOrNull();

  Future<int> upsertCategory(CategoriesCompanion category) async {
    final name = category.name.value;
    final existing = await getCategoryByName(name);
    if (existing != null) {
      await (update(categories)..where((c) => c.id.equals(existing.id))).write(category);
      return existing.id;
    } else {
      return into(categories).insert(category);
    }
  }

  Future<void> deleteCategoryById(int id) =>
      (delete(categories)..where((c) => c.id.equals(id))).go();

  Future<void> deleteCategoryByName(String name) =>
      (delete(categories)..where((c) => c.name.equals(name))).go();

  Future<void> deleteCategoriesNotIn(List<int> ids) =>
      (delete(categories)..where((c) => c.id.isNotIn(ids))).go();

  Future<List<MenuItem>> getAllMenuItems() => select(menuItems).get();

  Future<int> upsertMenuItem(MenuItemsCompanion item) async {
    final name = item.name.value;
    final existing = await (select(menuItems)..where((m) => m.name.equals(name))).getSingleOrNull();
    if (existing != null) {
      await (update(menuItems)..where((m) => m.id.equals(existing.id))).write(item);
      return existing.id;
    } else {
      return into(menuItems).insert(item);
    }
  }

  Future<void> deleteMenuItemById(int id) =>
      (delete(menuItems)..where((m) => m.id.equals(id))).go();

  Future<void> deleteMenuItemByName(String name) =>
      (delete(menuItems)..where((m) => m.name.equals(name))).go();

  Future<void> deleteMenuItemsNotIn(List<int> ids) =>
      (delete(menuItems)..where((m) => m.id.isNotIn(ids))).go();

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

  // ── Phase 2: Tasks, Customers, Staff & Attendance ──────────────────────────

  Stream<List<Task>> watchAllTasks() =>
      (select(tasks)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();

  Stream<List<Task>> watchTasksByCategory(String category) =>
      (select(tasks)
            ..where((t) => t.category.equals(category))
            ..orderBy([(t) => OrderingTerm.asc(t.priority), (t) => OrderingTerm.asc(t.title)]))
          .watch();

  Future<List<Task>> getAllTasks() => select(tasks).get();

  Future<int> insertTask(TasksCompanion task) => into(tasks).insert(task);

  Future<void> updateTask(TasksCompanion task) =>
      (update(tasks)..where((t) => t.id.equals(task.id.value))).write(task);

  Future<void> deleteTask(int taskId) =>
      (delete(tasks)..where((t) => t.id.equals(taskId))).go();

  Future<void> toggleTaskStatus(int taskId, String newStatus, {String? completedBy}) {
    return (update(tasks)..where((t) => t.id.equals(taskId))).write(
      TasksCompanion(
        status: Value(newStatus),
        completedAt: Value(newStatus == 'completed' ? DateTime.now() : null),
        completedBy: Value(newStatus == 'completed' ? completedBy : null),
      ),
    );
  }

  Future<void> updateTaskStatus(int taskId, String newStatus, {String? completedBy}) =>
      toggleTaskStatus(taskId, newStatus, completedBy: completedBy);

  Stream<List<Customer>> watchAllCustomers() =>
      (select(customers)..orderBy([(c) => OrderingTerm.desc(c.totalSpent)])).watch();

  Future<List<Customer>> getAllCustomers() => select(customers).get();

  Future<Customer?> getCustomerByPhone(String phone) =>
      (select(customers)..where((c) => c.phone.equals(phone))).getSingleOrNull();

  Future<int> insertCustomer(CustomersCompanion customer) =>
      into(customers).insert(customer);

  Future<void> updateCustomer(CustomersCompanion customer) =>
      (update(customers)..where((c) => c.id.equals(customer.id.value))).write(customer);

  Future<void> deleteCustomer(int id) =>
      (delete(customers)..where((c) => c.id.equals(id))).go();

  Future<bool> redeemCustomerStamps(int customerId) async {
    final customer = await (select(customers)..where((c) => c.id.equals(customerId))).getSingleOrNull();
    if (customer == null || customer.stampsCount < 9) return false;
    await (update(customers)..where((c) => c.id.equals(customerId))).write(
      CustomersCompanion(
        stampsCount: Value(customer.stampsCount - 9),
        lastVisitedAt: Value(DateTime.now()),
      ),
    );
    return true;
  }

  Future<void> addCustomerPointsAndSpend(int customerId, double spentAmount) async {
    final customer = await (select(customers)..where((c) => c.id.equals(customerId))).getSingleOrNull();
    if (customer == null) return;
    final newPoints = customer.points + spentAmount.floor();
    final newTotalSpent = customer.totalSpent + spentAmount;
    final newStamps = (customer.stampsCount + 1) % 9;

    String tier = 'Bronze';
    if (newTotalSpent > 1000) {
      tier = 'Platinum';
    } else if (newTotalSpent > 500) {
      tier = 'Gold';
    } else if (newTotalSpent > 150) {
      tier = 'Silver';
    }

    await (update(customers)..where((c) => c.id.equals(customerId))).write(
      CustomersCompanion(
        points: Value(newPoints),
        totalSpent: Value(newTotalSpent),
        stampsCount: Value(newStamps),
        tier: Value(tier),
        lastVisitedAt: Value(DateTime.now()),
      ),
    );
  }

  Stream<List<StaffMember>> watchAllStaff() =>
      (select(staffMembers)..orderBy([(s) => OrderingTerm.asc(s.name)])).watch();

  Future<List<StaffMember>> getAllStaff() => select(staffMembers).get();

  Future<StaffMember?> getStaffByPin(String pin) =>
      (select(staffMembers)..where((s) => s.pinCode.equals(pin) & s.isActive.equals(true))).getSingleOrNull();

  Future<StaffMember?> verifyStaffPin(String pin) => getStaffByPin(pin);

  Future<StaffMember?> getStaffById(int id) =>
      (select(staffMembers)..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<int> insertStaff(StaffMembersCompanion staff) =>
      into(staffMembers).insert(staff);

  Future<void> updateStaff(StaffMembersCompanion staff) =>
      (update(staffMembers)..where((s) => s.id.equals(staff.id.value))).write(staff);

  Future<void> deleteStaff(int id) =>
      (delete(staffMembers)..where((s) => s.id.equals(id))).go();

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

  // ─────────────────────────────────────────────────────────────────────────
  // Phase 3: Suppliers, Purchase Orders, Stock Audits, Expenses & Petty Cash
  // ─────────────────────────────────────────────────────────────────────────

  // ── Suppliers ─────────────────────────────────────────────────────────────

  Stream<List<Supplier>> watchAllSuppliers() =>
      (select(suppliers)..orderBy([(s) => OrderingTerm.asc(s.name)])).watch();

  Future<List<Supplier>> getAllSuppliers() => select(suppliers).get();

  Future<Supplier?> getSupplierById(int id) =>
      (select(suppliers)..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<int> insertSupplier(SuppliersCompanion supplier) =>
      into(suppliers).insert(supplier);

  Future<void> updateSupplier(SuppliersCompanion supplier) =>
      (update(suppliers)..where((s) => s.id.equals(supplier.id.value))).write(supplier);

  Future<void> deleteSupplier(int id) =>
      (delete(suppliers)..where((s) => s.id.equals(id))).go();

  // ── Purchase Orders & Items ───────────────────────────────────────────────

  Stream<List<PurchaseOrder>> watchAllPurchaseOrders() =>
      (select(purchaseOrders)..orderBy([(p) => OrderingTerm.desc(p.orderDate)])).watch();

  Future<List<PurchaseOrder>> getAllPurchaseOrders() =>
      (select(purchaseOrders)..orderBy([(p) => OrderingTerm.desc(p.orderDate)])).get();

  Future<PurchaseOrder?> getPurchaseOrderById(int id) =>
      (select(purchaseOrders)..where((p) => p.id.equals(id))).getSingleOrNull();

  Stream<List<PurchaseOrderItem>> watchPurchaseOrderItems(int poId) =>
      (select(purchaseOrderItems)..where((i) => i.poId.equals(poId))).watch();

  Future<List<PurchaseOrderItem>> getPurchaseOrderItems(int poId) =>
      (select(purchaseOrderItems)..where((i) => i.poId.equals(poId))).get();

  Future<int> insertPurchaseOrder(
    PurchaseOrdersCompanion po,
    List<PurchaseOrderItemsCompanion> items,
  ) {
    return transaction(() async {
      final poId = await into(purchaseOrders).insert(po);
      for (final item in items) {
        await into(purchaseOrderItems).insert(item.copyWith(poId: Value(poId)));
      }
      return poId;
    });
  }

  Future<void> updatePurchaseOrderStatus(int poId, String status) async {
    await (update(purchaseOrders)..where((p) => p.id.equals(poId))).write(
      PurchaseOrdersCompanion(status: Value(status)),
    );
  }

  /// Mark PO as received and automatically add received quantities to Ingredient stock.
  Future<void> receivePurchaseOrder(int poId) {
    return transaction(() async {
      await (update(purchaseOrders)..where((p) => p.id.equals(poId))).write(
        PurchaseOrdersCompanion(
          status: const Value('received'),
          receivedDate: Value(DateTime.now()),
        ),
      );

      final items = await getPurchaseOrderItems(poId);
      for (final item in items) {
        final ing = await getIngredientById(item.ingredientId);
        if (ing != null) {
          final newStock = ing.currentStock + item.quantityOrdered;
          await updateIngredientStock(ing.id, newStock);
        }
        await (update(purchaseOrderItems)..where((i) => i.id.equals(item.id))).write(
          PurchaseOrderItemsCompanion(
            quantityReceived: Value(item.quantityOrdered),
          ),
        );
      }
    });
  }

  // ── Stock Audits (Stock Take) ──────────────────────────────────────────────

  Stream<List<StockAudit>> watchAllStockAudits() =>
      (select(stockAudits)..orderBy([(a) => OrderingTerm.desc(a.auditedAt)])).watch();

  Future<List<StockAudit>> getAllStockAudits() =>
      (select(stockAudits)..orderBy([(a) => OrderingTerm.desc(a.auditedAt)])).get();

  /// Insert a stock audit and optionally adjust the ingredient's current stock immediately.
  Future<int> insertStockAudit(
    StockAuditsCompanion audit, {
    bool adjustInventory = true,
  }) {
    return transaction(() async {
      final auditId = await into(stockAudits).insert(audit);
      if (adjustInventory) {
        final ingredientId = audit.ingredientId.value;
        final actualStock = audit.actualStock.value;
        await updateIngredientStock(ingredientId, actualStock);
      }
      return auditId;
    });
  }

  // ── Expenses & Petty Cash ──────────────────────────────────────────────────

  Stream<List<Expense>> watchAllExpenses() =>
      (select(expenses)..orderBy([(e) => OrderingTerm.desc(e.expenseDate)])).watch();

  Stream<List<Expense>> watchTodayExpenses() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    return (select(expenses)
          ..where((e) => e.expenseDate.isBiggerOrEqualValue(startOfDay))
          ..orderBy([(e) => OrderingTerm.desc(e.expenseDate)]))
        .watch();
  }

  Future<List<Expense>> getTodayExpenses() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    return (select(expenses)
          ..where((e) => e.expenseDate.isBiggerOrEqualValue(startOfDay))
          ..orderBy([(e) => OrderingTerm.desc(e.expenseDate)]))
        .get();
  }

  Future<double> getTodayTotalExpenses() async {
    final list = await getTodayExpenses();
    return list.fold<double>(0.0, (double sum, Expense e) => sum + e.amount);
  }

  Future<int> insertExpense(ExpensesCompanion expense) =>
      into(expenses).insert(expense);

  Future<void> deleteExpense(int id) =>
      (delete(expenses)..where((e) => e.id.equals(id))).go();

  // ── Cash Drawer Logs ───────────────────────────────────────────────────────

  Stream<List<CashDrawerLog>> watchCashDrawerLogs() =>
      (select(cashDrawerLogs)..orderBy([(l) => OrderingTerm.desc(l.createdAt)])).watch();

  Future<int> insertCashDrawerLog(CashDrawerLogsCompanion log) =>
      into(cashDrawerLogs).insert(log);

  Future<double> getTodayCashDrawerBalance() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final logs = await (select(cashDrawerLogs)
          ..where((l) => l.createdAt.isBiggerOrEqualValue(startOfDay)))
        .get();

    double balance = 0.0;
    for (final l in logs) {
      if (l.type == 'float_in' || l.type == 'cash_in') {
        balance += l.amount;
      } else if (l.type == 'cash_out' || l.type == 'drop') {
        balance -= l.amount;
      }
    }

    // Add cash sales today
    final ordersToday = await getTodayOrders();
    final cashOrders = ordersToday.where((o) => o.status == 'completed' && o.paymentMethod == 'cash');
    for (final o in cashOrders) {
      balance += o.totalAmount;
    }

    // Subtract cash expenses today
    final expensesToday = await getTodayExpenses();
    final cashExpenses = expensesToday.where((e) => e.paymentMethod == 'cash');
    for (final e in cashExpenses) {
      balance -= e.amount;
    }

    return balance;
  }
}
