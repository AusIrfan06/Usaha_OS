import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Usaha OS design system — warm cafe aesthetic with Material 3.
class AppTheme {
  AppTheme._();

  // ── Brand Palette ────────────────────────────────────────────────
  static const Color primaryCoffee = Color(0xFFC17F3A);
  static const Color darkEspresso = Color(0xFF3E2004);
  static const Color warmCream = Color(0xFFFDF8F3);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5EDE3);

  // ── Status Colors ────────────────────────────────────────────────
  static const Color successGreen = Color(0xFF2E7D32);
  static const Color warningAmber = Color(0xFFF57F17);
  static const Color dangerRed = Color(0xFFC62828);
  static const Color duitNowBlue = Color(0xFF003399);
  static const Color mutedText = Color(0xFF9E8E7E);

  // ── Light Theme ──────────────────────────────────────────────────
  static ThemeData lightTheme() {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: primaryCoffee,
          brightness: Brightness.light,
        ).copyWith(
          primary: primaryCoffee,
          onPrimary: Colors.white,
          secondary: darkEspresso,
          surface: warmCream,
          surfaceContainerHighest: surfaceVariant,
          onSurface: darkEspresso,
        );

    final base = GoogleFonts.interTextTheme();
    final textTheme = base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -1.0,
        color: darkEspresso,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: darkEspresso,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: darkEspresso,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: darkEspresso,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: darkEspresso,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: darkEspresso,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: darkEspresso,
      ),
      bodyLarge: base.bodyLarge?.copyWith(color: const Color(0xFF5C4033)),
      bodyMedium: base.bodyMedium?.copyWith(color: const Color(0xFF5C4033)),
      bodySmall: base.bodySmall?.copyWith(color: mutedText),
      labelSmall: base.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: mutedText,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: warmCream,
      textTheme: textTheme,

      // Cards
      cardTheme: CardThemeData(
        elevation: 4,
        color: cardBg,
        shadowColor: const Color(0x1A000000), // Soft 10% shadow
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.zero,
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: warmCream,
        surfaceTintColor: Colors.transparent,
        foregroundColor: darkEspresso,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: darkEspresso,
        ),
      ),

      // Buttons
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryCoffee,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryCoffee,
          side: const BorderSide(color: primaryCoffee, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryCoffee,
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primaryCoffee, width: 2),
        ),
        labelStyle: GoogleFonts.inter(color: mutedText, fontSize: 14),
        hintStyle: GoogleFonts.inter(color: mutedText, fontSize: 14),
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: surfaceVariant,
        selectedColor: primaryCoffee.withOpacity(0.18),
        labelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: Color(0xFFEDE3D8),
        thickness: 1,
        space: 1,
      ),

      // Navigation Rail (tablet)
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: cardBg,
        elevation: 2,
        selectedIconTheme: const IconThemeData(color: primaryCoffee, size: 24),
        selectedLabelTextStyle: GoogleFonts.inter(
          color: primaryCoffee,
          fontWeight: FontWeight.w800,
          fontSize: 11,
        ),
        unselectedIconTheme: const IconThemeData(color: mutedText, size: 24),
        unselectedLabelTextStyle: GoogleFonts.inter(
          color: mutedText,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        indicatorColor: primaryCoffee.withOpacity(0.12),
        useIndicator: true,
        minWidth: 80,
        minExtendedWidth: 220,
      ),

      // Navigation Bar (phone)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardBg.withOpacity(
          0.95,
        ), // Slight transparency for modern look
        indicatorColor: primaryCoffee.withOpacity(0.14),
        elevation: 8,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryCoffee, size: 24);
          }
          return const IconThemeData(color: mutedText, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              color: primaryCoffee,
              fontWeight: FontWeight.w800,
              fontSize: 11,
            );
          }
          return GoogleFonts.inter(
            color: mutedText,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          );
        }),
        surfaceTintColor: Colors.transparent,
        shadowColor: const Color(0x20000000), // Subtle shadow
      ),

      // Tab Bar
      tabBarTheme: TabBarThemeData(
        labelColor: primaryCoffee,
        unselectedLabelColor: mutedText,
        indicatorColor: primaryCoffee,
        labelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        dividerColor: Colors.transparent,
      ),
    );
  }

  // ── Dark Theme ───────────────────────────────────────────────────
  static ThemeData darkTheme() {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: primaryCoffee,
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFFDCA86A),
          onPrimary: Colors.black,
          secondary: const Color(0xFFBE8C5C),
          surface: const Color(0xFF1A1208),
          surfaceContainerHighest: const Color(0xFF2A1E10),
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFF1A1208),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      cardTheme: CardThemeData(
        elevation: 0,
        color: const Color(0xFF2A1E10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
