/// Currency formatting utilities for Malaysian Ringgit (MYR).
class CurrencyFormatter {
  CurrencyFormatter._();

  /// e.g. 13.50 → "RM 13.50"
  static String format(double amount) =>
      'RM ${amount.toStringAsFixed(2)}';

  /// Compact format for large numbers: 1500 → "RM 1.5K"
  static String formatCompact(double amount) {
    if (amount >= 1000000) {
      return 'RM ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return 'RM ${(amount / 1000).toStringAsFixed(1)}K';
    }
    return format(amount);
  }

  /// Parse a formatted string back to double.
  static double parse(String value) {
    final cleaned = value.replaceAll('RM', '').replaceAll(',', '').trim();
    return double.tryParse(cleaned) ?? 0.0;
  }
}
