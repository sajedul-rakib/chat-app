import 'package:chat_app/theme/color_scheme.dart';
import 'package:chat_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

class SnackBarTheme {
  const SnackBarTheme._();

  static SnackBarThemeData lightSnackbarTheme = SnackBarThemeData(
      backgroundColor: ColorSchemed.lightColorScheme.primary,
      contentTextStyle: MobileTextTheme.textTheme.displayLarge!.copyWith(
        color: ColorSchemed.lightColorScheme.onPrimary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)));

  static SnackBarThemeData darkSnackbarTheme = SnackBarThemeData(
      backgroundColor: ColorSchemed.darkColorScheme.primary,
      contentTextStyle: MobileTextTheme.textTheme.displayLarge!.copyWith(
        color: ColorSchemed.darkColorScheme.onPrimary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)));
}
