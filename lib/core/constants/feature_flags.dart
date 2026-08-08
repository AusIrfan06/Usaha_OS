/// Feature flags — modular toggles for Usaha OS ecosystem.
class FeatureFlags {
  FeatureFlags._();

  /// SST (Service & Sales Tax) 6% on F&B service.
  /// Phase 3: Active and configurable in settings.
  static const bool sstEnabled = true;
  static const double sstRate = 0.06;

  /// LHDN e-Invoice (MyInvois) — built dormant, zero cashier impact.
  /// Enable when annual turnover crosses RM1 million (Phase 5).
  static const bool eInvoiceEnabled = false;

  /// KDS (Kitchen Display System) — Phase 2 [ACTIVE].
  static const bool kdsEnabled = true;

  /// CRM & Loyalty (Points, Stamp Cards) — Phase 2 [ACTIVE].
  static const bool crmEnabled = true;

  /// Task Management & Shift Operations — Phase 2 [ACTIVE].
  static const bool tasksEnabled = true;

  /// Staff Attendance & Shift Logs — Phase 2 [ACTIVE].
  static const bool staffEnabled = true;

  /// Supplier & Purchase Order Management — Phase 3 [ACTIVE].
  static const bool suppliersEnabled = true;

  /// Stock Take & Inventory Variance Audit — Phase 3 [ACTIVE].
  static const bool stockTakeEnabled = true;

  /// Expense & Petty Cash Management — Phase 3 [ACTIVE].
  static const bool expensesEnabled = true;

  /// Multi-outlet sync — Phase 4.
  static const bool multiOutletEnabled = false;
}
