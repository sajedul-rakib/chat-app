import 'package:chat_app/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class MobileAppBarTheme {
  const MobileAppBarTheme._();

  static AppBarTheme lightAppBarTheme = const AppBarTheme(
      backgroundColor: AppColors.primaryLightBackground,
      titleTextStyle: TextStyle(
          fontSize: 24,
          color: AppColors.lightIconColor,
          fontWeight: FontWeight.w400),
      actionsIconTheme:
          IconThemeData(color: AppColors.lightIconColor, size: 22));

  static AppBarTheme darkAppBarTheme = const AppBarTheme(
      titleTextStyle: TextStyle(
          fontSize: 24,
          color: AppColors.darkIconColor,
          fontWeight: FontWeight.w400),
      backgroundColor: AppColors.primaryDarkBackground,
      actionsIconTheme:
          IconThemeData(color: AppColors.darkIconColor, size: 22));
}
