import 'package:chat_app/theme/color_scheme.dart';
import 'package:flutter/material.dart';

class MobileTextButtonTheme {
  const MobileTextButtonTheme._();

  static TextButtonThemeData lightTextButtonTheme(BuildContext context) =>
      TextButtonThemeData(
          style: TextButton.styleFrom(
              textStyle: TextStyle(
                  fontSize: 16,
                  color: ColorSchemed.lightColorScheme.onPrimary,
                  fontWeight: FontWeight.w500)));

  static TextButtonThemeData darkTextButtonTheme(BuildContext context) =>
      TextButtonThemeData(
          style: TextButton.styleFrom(
              textStyle: TextStyle(
                  fontSize: 16,
                  color: ColorSchemed.darkColorScheme.onPrimary,
                  fontWeight: FontWeight.w500)));
}
