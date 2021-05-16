import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  // textTheme: GoogleFonts.openSansTextTheme(),
  primaryColorDark: const Color(0xFF81EBEF),
  primaryColorLight: const Color(0xFF00FF00),
  primaryColor: const Color(0xFFFFFF00),
  accentColor: const Color(0xFF009688),
  scaffoldBackgroundColor: const Color(0xFFE0F2F1),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  textTheme: TextTheme(
    headline5: TextStyle(
      fontFamily: "ANasr",
      color: const Color(0xFF75C28C),
      fontSize: 24,
    ),
  ),
);
