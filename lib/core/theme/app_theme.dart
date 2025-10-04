import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.pinkAccent,
    ),
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
