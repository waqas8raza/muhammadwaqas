import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Editorial design token system for Muhammad Waqas's portfolio.
/// Warm off-white background, deep charcoal text, rich terracotta burnt orange accent,
/// and restrained, timeless typography.
class AppTheme {
  // Primary Palette
  static const Color background = Color(0xFFF9F8F5); // Warm gallery off-white
  static const Color surface = Color(0xFFFFFFFF); // Pristine white card surface
  static const Color surfaceSubtle = Color(0xFFF2EFE9); // Soft neutral panel
  static const Color surfaceHover = Color(0xFFEBE7DF); // Interactive surface

  // Text Colors
  static const Color textPrimary = Color(0xFF141518); // Deep charcoal
  static const Color textSecondary = Color(0xFF555963); // Readable slate
  static const Color textMuted = Color(0xFF7E8490); // Muted metadata
  static const Color textLight = Color(0xFFFFFFFF); // Light text on dark/accent

  // Borders & Hairlines
  static const Color border = Color(0xFFE4E1D8); // Subtle hairline border
  static const Color borderStrong = Color(0xFFCCC7BB); // Defined divider

  // Accent Colors — Burnt Orange / Terracotta
  static const Color accent = Color(0xFFBD4A23); // Signature terracotta burnt orange
  static const Color accentDark = Color(0xFF9E3A17); // Deep pressed terracotta
  static const Color accentLight = Color(0xFFFBF0EA); // Warm accent background tint
  static const Color accentBorder = Color(0xFFE8B6A2); // Gentle accent outline

  // Semantic
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFC62828);

  static ThemeData get lightEditorialTheme {
    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      primaryColor: accent,
      colorScheme: const ColorScheme.light(
        primary: accent,
        onPrimary: textLight,
        secondary: accentDark,
        onSecondary: textLight,
        surface: surface,
        onSurface: textPrimary,
        error: error,
        onError: textLight,
      ),
      textTheme: baseTextTheme.copyWith(
        // Editorial Display Serifs
        displayLarge: GoogleFonts.newsreader(
          color: textPrimary,
          fontSize: 54,
          fontWeight: FontWeight.w600,
          letterSpacing: -1.2,
          height: 1.1,
        ),
        displayMedium: GoogleFonts.newsreader(
          color: textPrimary,
          fontSize: 38,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.8,
          height: 1.15,
        ),
        displaySmall: GoogleFonts.newsreader(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        // Clean Sans Titles
        headlineMedium: GoogleFonts.plusJakartaSans(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
        titleMedium: GoogleFonts.plusJakartaSans(
          color: textPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: GoogleFonts.plusJakartaSans(
          color: textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        // Body
        bodyLarge: GoogleFonts.plusJakartaSans(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        bodySmall: GoogleFonts.plusJakartaSans(
          color: textMuted,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        // Technical labels / mono accents
        labelMedium: GoogleFonts.jetBrainsMono(
          color: textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
        ),
        labelSmall: GoogleFonts.jetBrainsMono(
          color: accent,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: border,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: textMuted,
          fontSize: 14,
        ),
        labelStyle: GoogleFonts.plusJakartaSans(
          color: textSecondary,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: error),
        ),
      ),
    );
  }

  // Keep darkTheme alias for compatibility
  static ThemeData get darkTheme => lightEditorialTheme;
}
