import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeShared {

  //set theme mode
  static void setThemeMode(String themeMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("mode", themeMode);
  }

  //get theme mode
  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences.getString("mode");
    return theme;
  }

}
