import 'package:chat_app/theme/color_scheme.dart';
import 'package:flutter/material.dart';

class MobileListTileTheme {
  const MobileListTileTheme._();

  static ListTileThemeData lightListTileTheme = ListTileThemeData(
      titleTextStyle: TextStyle(
        color: ColorSchemed.lightColorScheme.onPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      subtitleTextStyle: TextStyle(
        color: ColorSchemed.lightColorScheme.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ));

  static ListTileThemeData darkListTileTheme = ListTileThemeData(
      titleTextStyle: TextStyle(
        color: ColorSchemed.darkColorScheme.onPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      subtitleTextStyle: TextStyle(
        color: ColorSchemed.darkColorScheme.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ));
}
