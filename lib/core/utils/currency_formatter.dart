/// Currency formatting utilities for Malaysian Ringgit (MYR).
class CurrencyFormatter {
  CurrencyFormatter._();

  /// e.g. 13.50 → "RM 13.50"
  static String format(num? amount) {
    final val = (amount?.toDouble()) ?? 0.0;
    return 'RM ${val.toStringAsFixed(2)}';
  }

  /// Compact format for large numbers: 1500 → "RM 1.5K"
  static String formatCompact(num? amount) {
    final val = (amount?.toDouble()) ?? 0.0;
    if (val >= 1000000) {
      return 'RM ${(val / 1000000).toStringAsFixed(1)}M';
    } else if (val >= 1000) {
      return 'RM ${(val / 1000).toStringAsFixed(1)}K';
    }
    return format(val);
  }

  /// Parse a formatted string back to double.
  static double parse(String value) {
    final cleaned = value.replaceAll('RM', '').replaceAll(',', '').trim();
    return double.tryParse(cleaned) ?? 0.0;
  }
}

