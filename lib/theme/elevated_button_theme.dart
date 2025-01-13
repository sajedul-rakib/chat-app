import 'package:chat_app/theme/color_scheme.dart';
import 'package:flutter/material.dart';

class AppElevatedButtonTheme {
  const AppElevatedButtonTheme._();

  static ElevatedButtonThemeData lightButtonTheme(BuildContext context) =>
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              iconColor: ColorSchemed.lightColorScheme.onSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              textStyle:
                  TextStyle(color: ColorSchemed.lightColorScheme.onSecondary),
              backgroundColor: ColorSchemed.lightColorScheme.secondary));

  static ElevatedButtonThemeData darkButtonTheme(BuildContext context) =>
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              iconColor: ColorSchemed.darkColorScheme.onSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              textStyle:
                  TextStyle(color: ColorSchemed.darkColorScheme.onSecondary),
              backgroundColor: ColorSchemed.darkColorScheme.secondary));
}
