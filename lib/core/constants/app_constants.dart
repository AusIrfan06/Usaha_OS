/// Usaha OS — App-wide constants
class AppConstants {
  AppConstants._();

  static const String appName = 'Usaha OS';
  static const String currency = 'RM';
  static const String version = '1.0.0';

  // ── Order Types ──────────────────────────────────────────────────
  static const String dineIn = 'dine_in';
  static const String takeaway = 'takeaway';
  static const String delivery = 'delivery';

  // ── Order Statuses ───────────────────────────────────────────────
  static const String orderPending = 'pending';
  static const String orderInProgress = 'in_progress';
  static const String orderReady = 'ready';
  static const String orderCompleted = 'completed';
  static const String orderVoided = 'voided';

  // ── Payment Methods ───────────────────────────────────────────────
  static const String cash = 'cash';
  static const String duitNowQr = 'duitnow_qr';
  static const String card = 'card';

  // ── Preparation Stations ─────────────────────────────────────────
  static const String stationKitchen = 'kitchen';
  static const String stationBar = 'bar';
  static const String stationPastry = 'pastry';
}
