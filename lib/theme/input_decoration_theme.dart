import 'package:flutter/material.dart';

import '../core/constants/colors/app_colors.dart';

class MobileInputDecorationTheme {
  const MobileInputDecorationTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
      filled: true,
      fillColor: AppColors.secondaryLightBackground,
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
      contentPadding: const EdgeInsets.all(10),
      labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.disabledColor),
      iconColor: AppColors.disabledColor);

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
      filled: true,
      fillColor: AppColors.secondaryDarkBackground,
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
      contentPadding: const EdgeInsets.all(10),
      labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.disabledColor),
      iconColor: AppColors.disabledColor);
}
