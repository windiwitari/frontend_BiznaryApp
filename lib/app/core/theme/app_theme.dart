import 'package:flutter/material.dart';

class AppColors {
  static const primaryBlue = Color(0xFF0056BC); // Biru Biznary sesuai UI
  static const lightGray = Color(0xFFF8F9FB);
}

final ThemeData appThemeData = ThemeData(
  primaryColor: AppColors.primaryBlue,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Inter', // Sesuaikan dengan font di UI/UX Anda
);