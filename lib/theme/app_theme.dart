import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static String fontFamily = 'Atma';
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.secondaryBlue,
    fontFamily: fontFamily, // Burada global font ayarını yaptık ✅
    appBarTheme: AppBarTheme(
      color: AppColors.primaryBlue,
      foregroundColor: AppColors.white,
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.white,
        fontFamily: fontFamily, // Fontu burada da verdik ✅
      ),
      bodyMedium: TextStyle(color: AppColors.white, fontFamily: fontFamily),
      titleLarge: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
      ),
    ),
    cardColor: AppColors.thirdBlue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryBlue,
      secondary: AppColors.white,
      surface: AppColors.white,
      error: AppColors.falseRed,
    ),
    canvasColor: Colors.black,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.darkGrey,
    fontFamily: fontFamily, // Global font dark modda da aynı ✅
    appBarTheme: AppBarTheme(
      color: AppColors.grey,
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.white, fontFamily: fontFamily),
      bodyMedium: TextStyle(color: AppColors.white, fontFamily: fontFamily),
      titleLarge: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
      ),
    ),
    cardColor: AppColors.grey,
    primaryColorLight: AppColors.grey,
    colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
      primary: AppColors.primaryBlue,
      secondary: AppColors.darkGrey,
      surface: AppColors.grey,
      error: AppColors.falseRed,
    ),
    canvasColor: Colors.white,
  );
}
