/// Feature flags — dormant modules ready to be enabled.
/// Flip these to `true` when the business crosses the relevant threshold.
class FeatureFlags {
  FeatureFlags._();

  /// SST (Service & Sales Tax) 6% on F&B service.
  /// Enable when annual F&B service revenue crosses RM1.5 million.
  static const bool sstEnabled = false;
  static const double sstRate = 0.06;

  /// LHDN e-Invoice (MyInvois) — built dormant, zero cashier impact.
  /// Enable when annual turnover crosses RM1 million.
  static const bool eInvoiceEnabled = false;

  /// KDS (Kitchen Display System) — Phase 2.
  static const bool kdsEnabled = false;

  /// CRM & Loyalty — Phase 2.
  static const bool crmEnabled = false;

  /// Multi-outlet sync — Phase 4.
  static const bool multiOutletEnabled = false;
}
