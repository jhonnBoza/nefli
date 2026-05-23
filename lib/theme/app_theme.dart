import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tema global estilo Netflix con 3 tipos de letra.
class AppTheme {
  static const Color netflixRed = Color(0xFFE50914);
  static const Color netflixBlack = Color(0xFF141414);
  static const Color netflixDark = Color(0xFF0B0B0B);
  static const Color netflixGray = Color(0xFFB3B3B3);

  static TextStyle get displayFont => GoogleFonts.bebasNeue(
        fontSize: 32,
        color: Colors.white,
        letterSpacing: 1.2,
      );

  static TextStyle get bodyFont => GoogleFonts.roboto(
        fontSize: 14,
        color: Colors.white,
      );

  static TextStyle get accentFont => GoogleFonts.montserrat(
        fontSize: 13,
        color: netflixGray,
        fontWeight: FontWeight.w500,
      );

  static ThemeData get darkTheme {
    final base = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: netflixBlack,
      primaryColor: netflixRed,
      colorScheme: const ColorScheme.dark(
        primary: netflixRed,
        secondary: netflixRed,
        surface: netflixBlack,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: netflixDark,
        elevation: 0,
        titleTextStyle: displayFont.copyWith(fontSize: 22),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1F1F1F),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: netflixRed,
        textColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: netflixRed,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: displayFont,
        headlineMedium: displayFont.copyWith(fontSize: 24),
        titleLarge: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyMedium: bodyFont,
        bodySmall: accentFont,
        labelLarge: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );

    return base;
  }
}
