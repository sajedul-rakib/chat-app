import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  static bool? isFirstOpen;

  //for check the app is first openly
  static Future<bool?> checkIsFirstOpen() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isFirstOpen = sharedPreferences.getBool("isFirst");
    return isFirstOpen;
  }

  // //set the app is open first or last
  // static setIsFirstOpen(bool isFirst) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return sharedPreferences.setBool("isFirst", isFirst);
  // }

  //save string at local
  static Future<void> saveToLocal(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  //get save local item
  static Future<String?> getLocalSaveItem(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString(key);
    return result;
  }
}
