import 'package:flutter/material.dart';

class ColorSchemed {
  const ColorSchemed._();

  static ColorScheme lightColorScheme = const ColorScheme.light(
    primary: Color(0xffFFFFFF),
    onPrimary: Color(0xff0F1828),
    secondary: Color(0xff002DE3),
    onSecondary: Color(0xffF7F7FC),
    error: Color(0xffE94242),
    onError: Color(0xffFFFFFF),
    surface: Color(0xffffffff),
    onSurface: Color(0xff0F1828),
    tertiary: Color(0xff152033),
  );

  static ColorScheme darkColorScheme = const ColorScheme.dark(
    primary: Color(0xff0F1828),
    onPrimary: Color(0xffF7F7FC),
    secondary: Color(0xff375FFF),
    onSecondary: Color(0xffF7F7FC),
    error: Color(0xffE94242),
    onError: Color(0xffFFFFFF),
    surface: Color(0xff0F1828),
    onSurface: Color(0xffF7F7FC),
    tertiary: Color(0xff152033),
  );
}
