import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const starYellow = Color(0xFFF5D547); // aksen untuk dark mode
  static const barGray = Color(0xFF4D4D4D);
  static const darkGold = Color(0xFF8A6D00); // aksen untuk light mode

  static TextTheme get _textTheme => TextTheme(
    headlineMedium: GoogleFonts.barlowCondensed(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 1.15,
    ),
    titleLarge: GoogleFonts.barlowCondensed(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.15,
    ),
    titleMedium: GoogleFonts.barlowCondensed(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.2,
    ),
    titleSmall: GoogleFonts.barlowCondensed(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.5,
    ),
    bodyLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    labelMedium: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
    ),
  );

  static NavigationBarThemeData _navigationBarTheme(ColorScheme scheme) {
    return NavigationBarThemeData(
      indicatorColor: starYellow,
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? black
              : scheme.onSurfaceVariant,
        ),
      ),
    );
  }

  static ThemeData get dark {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: starYellow,
          brightness: Brightness.dark,
        ).copyWith(
          primary: starYellow,
          onPrimary: black,
          secondary: white,
          onSecondary: black,
          secondaryContainer: barGray,
          onSecondaryContainer: white,
          tertiary: starYellow,
          onTertiary: black,
          surface: black,
          onSurface: white,
          onSurfaceVariant: const Color(0xFFB3B3B3),
          surfaceContainerLow: const Color(0xFF121212),
          surfaceContainerHigh: const Color(0xFF1E1E1E),
          outlineVariant: const Color(0xFF333333),
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: _textTheme,
      scaffoldBackgroundColor: black,
      appBarTheme: const AppBarTheme(
        backgroundColor: black,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      chipTheme: ChipThemeData(side: BorderSide(color: scheme.outlineVariant)),
      navigationBarTheme: _navigationBarTheme(scheme),
    );
  }

  static ThemeData get light {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: starYellow,
          brightness: Brightness.light,
        ).copyWith(
          primary: darkGold,
          onPrimary: white,
          secondary: black,
          onSecondary: white,
          secondaryContainer: const Color(0xFFE0E0E0),
          onSecondaryContainer: black,
          tertiary: darkGold,
          onTertiary: white,
          surface: white,
          onSurface: black,
          onSurfaceVariant: barGray,
          surfaceContainerLow: const Color(0xFFF5F5F5),
          surfaceContainerHigh: const Color(0xFFE8E8E8),
          outlineVariant: const Color(0xFFCCCCCC),
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: _textTheme,
      scaffoldBackgroundColor: white,
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      chipTheme: ChipThemeData(side: BorderSide(color: scheme.outlineVariant)),
      navigationBarTheme: _navigationBarTheme(scheme),
    );
  }
}
