import 'package:flutter/material.dart';
import 'package:hitam_app/core/constants/app_colors.dart';

class AppTheme {
  // Typography
  static const footerText = TextStyle(
    fontSize: 12,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w500,
    color: AppColors.dark,
  );

  static const headerText = TextStyle(
    fontSize: 24,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w600,
    color: AppColors.dark,
  );

  // Primary button style
  static final ButtonStyle primaryButton = ButtonStyle(
    elevation: const WidgetStatePropertyAll(0),
    backgroundColor: WidgetStatePropertyAll(AppColors.primary),
    foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
    padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  );

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    fontFamily: 'poppins',
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.dark),
      titleLarge: headerText,
      labelSmall: footerText,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButton),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.dark,
      elevation: 0,
      titleTextStyle: headerText,
    ),
  );
}
