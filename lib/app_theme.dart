import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  // textTheme: GoogleFonts.openSansTextTheme(),
  primaryColorDark: const Color(0xFFFF0000),
  primaryColorLight: const Color(0xFF00FF00),
  primaryColor: const Color(0xFFFFFF00),
  accentColor: const Color(0xFF009688),
  scaffoldBackgroundColor: const Color(0xFFE0F2F1),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
