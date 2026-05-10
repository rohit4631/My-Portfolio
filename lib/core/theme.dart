import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color background = Color(0xFF0F172A);
  static const Color primary = Color(0xFF8B5CF6);
  static const Color secondary = Color(0xFF3B82F6);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color cardBackground = Color(0x0AFFFFFF); // More transparent white for better background bubble visibility
  static const Color glassBorder = Color(0x1AFFFFFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        background: background, // Note: background is deprecated but used here for compatibility, using scaffoldBackgroundColor is enough
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.inter(fontSize: 56, fontWeight: FontWeight.bold, color: textPrimary, letterSpacing: -1.5),
        displayMedium: GoogleFonts.inter(fontSize: 40, fontWeight: FontWeight.bold, color: textPrimary, letterSpacing: -0.5),
        headlineLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold, color: textPrimary),
        titleLarge: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, color: textPrimary),
        bodyLarge: GoogleFonts.inter(fontSize: 18, color: textSecondary, height: 1.6),
        bodyMedium: GoogleFonts.inter(fontSize: 16, color: textSecondary, height: 1.6),
      ),
    );
  }
}
