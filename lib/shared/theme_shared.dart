import 'package:shared_preferences/shared_preferences.dart';

class ThemeShared {
  static void setThemeMode(String themeMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("mode", themeMode);
  }

  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences.getString("mode");
    return theme;
  }
}
