import 'package:chat_app/theme/app_bar_theme.dart';
import 'package:chat_app/theme/bottom_nav_bar_theme.dart';
import 'package:chat_app/theme/color_scheme.dart';
import 'package:chat_app/theme/divider_theme.dart';
import 'package:chat_app/theme/elevated_button_theme.dart';
import 'package:chat_app/theme/input_decoration_theme.dart';
import 'package:chat_app/theme/list_tile_theme.dart';
import 'package:chat_app/theme/snack_bar_theme.dart';
import 'package:chat_app/theme/text_button_theme.dart';
import 'package:chat_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme(BuildContext context) => ThemeData(
      useMaterial3: true,
      colorScheme: ColorSchemed.lightColorScheme,
      bottomNavigationBarTheme: BottomNavBarTheme.lightBottomNavBarTheme,
      appBarTheme: MobileAppBarTheme.lightAppBarTheme,
      fontFamily: 'Mulish',
      dividerTheme: MobileDividerTheme.lightDividerTheme,
      scaffoldBackgroundColor: ColorSchemed.lightColorScheme.primary,
      inputDecorationTheme:
          MobileInputDecorationTheme.lightInputDecorationTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.lightButtonTheme(context),
      textButtonTheme: MobileTextButtonTheme.lightTextButtonTheme(context),
      listTileTheme: MobileListTileTheme.lightListTileTheme,
      textTheme: MobileTextTheme.textTheme,
      snackBarTheme: SnackBarTheme.lightSnackbarTheme);

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      useMaterial3: true,
      colorScheme: ColorSchemed.darkColorScheme,
      bottomNavigationBarTheme: BottomNavBarTheme.darkBottomNavBarTheme,
      appBarTheme: MobileAppBarTheme.darkAppBarTheme,
      dividerTheme: MobileDividerTheme.darkDividerTheme,
      inputDecorationTheme: MobileInputDecorationTheme.darkInputDecorationTheme,
      fontFamily: 'Mulish',
      scaffoldBackgroundColor: ColorSchemed.darkColorScheme.primary,
      elevatedButtonTheme: AppElevatedButtonTheme.darkButtonTheme(context),
      textButtonTheme: MobileTextButtonTheme.darkTextButtonTheme(context),
      listTileTheme: MobileListTileTheme.darkListTileTheme,
      textTheme: MobileTextTheme.textTheme,
      snackBarTheme: SnackBarTheme.darkSnackbarTheme);
}
