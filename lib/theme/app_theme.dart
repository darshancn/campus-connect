import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    primaryColor: Color(0xFF1D97D4),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Inter',
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    ),
  );
}
