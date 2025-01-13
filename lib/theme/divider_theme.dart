import 'package:chat_app/theme/color_scheme.dart';
import 'package:flutter/material.dart';

class MobileDividerTheme {
  const MobileDividerTheme._();

  static DividerThemeData lightDividerTheme = DividerThemeData(
      thickness: 1.5, color: ColorSchemed.lightColorScheme.onSecondary);

  static DividerThemeData darkDividerTheme = DividerThemeData(
      thickness: 1.5, color: ColorSchemed.darkColorScheme.tertiary);
}
