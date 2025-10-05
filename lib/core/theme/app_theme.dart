import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 🎨 Nueva paleta de colores
  static const Color beigeClaro = Color(0xFFFEF6E4);      // #fef6e4
  static const Color rosaFuerte = Color(0xFFF582AE);      // #f582ae
  static const Color azulCeleste = Color(0xFF3B43DD);     // #3b43dd
  static const Color azulMarino = Color(0xFF001858);      // #001858
  static const Color rosaClaro = Color(0xFFF3D2C1);       // #f3d2c1

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: azulCeleste,
      secondary: rosaFuerte,
      surface: beigeClaro,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: azulMarino,
      tertiary: rosaClaro,
      outline: azulMarino.withValues(alpha: 0.3),
    ),
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: azulMarino,
      displayColor: azulMarino,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: azulCeleste,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: azulCeleste,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}
