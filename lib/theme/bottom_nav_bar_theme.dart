import 'package:chat_app/core/constants/colors/app_colors.dart';
import 'package:chat_app/theme/color_scheme.dart';
import 'package:flutter/material.dart';

class BottomNavBarTheme {
  const BottomNavBarTheme._();

  static BottomNavigationBarThemeData lightBottomNavBarTheme =
      BottomNavigationBarThemeData(
    backgroundColor: ColorSchemed.lightColorScheme.primary,
    unselectedIconTheme: const IconThemeData(color: AppColors.lightIconColor),
    selectedLabelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.lightIconColor),
    selectedIconTheme:
        const IconThemeData(color: AppColors.primaryDarkBackground, size: 6),
    selectedItemColor: AppColors.lightIconColor,
  );

  static BottomNavigationBarThemeData darkBottomNavBarTheme =
      BottomNavigationBarThemeData(
          backgroundColor: ColorSchemed.darkColorScheme.primary,
          unselectedIconTheme:
              const IconThemeData(color: AppColors.darkIconColor),
          selectedItemColor: AppColors.primaryLightBackground,
          selectedLabelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.darkIconColor),
          selectedIconTheme: const IconThemeData(
              color: AppColors.primaryLightBackground, size: 6));
}
