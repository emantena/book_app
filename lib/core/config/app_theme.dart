import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.primaryBackground,
    textTheme: TextTheme(
      titleSmall: _getTextStyle(
        fontSize: 18,
        color: AppColors.secondaryText,
      ),
      titleMedium: _getTextStyle(
        fontSize: 20,
        color: AppColors.secondaryText,
      ),
      bodySmall: _getTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryText,
      ),
      bodyMedium: _getTextStyle(
        fontSize: 14,
        color: AppColors.secondaryText,
      ),
      bodyLarge: _getTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryText,
      ),
      headlineLarge: _getTextStyle(
        fontSize: 16,
        color: AppColors.primaryText,
      ),
      headlineMedium: _getTextStyle(
        fontSize: 14,
        color: AppColors.secondaryText,
      ),
      headlineSmall: _getTextStyle(
        fontSize: 12,
        color: AppColors.secondaryText,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.primaryBtnText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.primaryBackground,
      onPrimary: AppColors.primaryBtnText,
      onSecondary: AppColors.primaryText,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryBackground,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.unselectedColor,
      type: BottomNavigationBarType.fixed,
    ),
  );
}

TextStyle _getTextStyle({
  required double fontSize,
  FontWeight fontWeight = FontWeight.w600,
  required Color color,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}
