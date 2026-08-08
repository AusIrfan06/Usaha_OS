/// Feature flags — modular toggles for Usaha OS ecosystem.
class FeatureFlags {
  FeatureFlags._();

  /// SST (Service & Sales Tax) 6% on F&B service.
  /// Enable when annual F&B service revenue crosses RM1.5 million (Phase 3).
  static const bool sstEnabled = false;
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

  /// Multi-outlet sync — Phase 4.
  static const bool multiOutletEnabled = false;
}
