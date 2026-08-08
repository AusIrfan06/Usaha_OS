import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Centralized Color Palette for Usaha OS
class AppColors {
  AppColors._();

  // Primary Coffee & Warm Theme
  static const Color primary = AppTheme.primaryCoffee;
  static const Color primaryDark = AppTheme.darkEspresso;
  static const Color background = AppTheme.warmCream;
  static const Color card = AppTheme.cardBg;
  static const Color surface = AppTheme.surfaceVariant;

  // Dark Theme Palette (for KDS & High-contrast modules)
  static const Color backgroundDark = Color(0xFF1E1611);
  static const Color surfaceDark = Color(0xFF2B1F17);
  static const Color cardDark = Color(0xFF38291E);

  // Status & Utility
  static const Color success = AppTheme.successGreen;
  static const Color warning = AppTheme.warningAmber;
  static const Color danger = AppTheme.dangerRed;
  static const Color textMuted = AppTheme.mutedText;
  static const Color textDark = AppTheme.darkEspresso;
}
