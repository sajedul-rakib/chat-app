import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  static SharedPreferences? _preferences;
  static String? _token;
  static String? _userId;

  static String? get token => _token;
  static String? get userId => _userId;

  // Initialize shared preferences and load token
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _token = _preferences?.getString('token');
    _token = _preferences?.getString('userId');
  }

  static SharedPreferences get instance {
    if (_preferences == null) {
      throw Exception("SharedPreferences not initialized. Call SharedData.init() first.");
    }
    return _preferences!;
  }

  // Check if the app is opened for the first time
  static Future<bool> checkIsFirstOpen() async {
    return instance.getBool("isFirst") ?? true;
  }

  // Set the app as no longer first open
  static Future<void> setIsFirstOpen() async {
    bool result = await instance.setBool("isFirst", false);
    log(result.toString());
  }

  // Save string to local storage
  static Future<void> saveToLocal(String key, String value) async {
    await instance.setString(key, value);
    if (key == "token") {
      _token = value; // Update the token value when saved
    }
    if(key=='userId'){
      _userId=value;
    }
  }

  // Get saved string from local storage
  static Future<String?> getLocalSaveItem(String key) async {
    final result = instance.getString(key);
    if (key == "token") {
      _token = result; // Update the token when retrieved
    }
    return result;
  }

  // Delete all saved items
  static Future<bool> deleteAllSave() async {
    bool result = await instance.clear();
    _token = null; // Reset token if everything is cleared
    return result;
  }
}
