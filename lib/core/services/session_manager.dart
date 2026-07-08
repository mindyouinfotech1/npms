import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveUser({
    required String uid,
    required String username,
    required String name,
  }) async {
    await _prefs.setBool("isLoggedIn", true);
    await _prefs.setString("uid", uid);
    await _prefs.setString("username", username);
    await _prefs.setString("name", name);
  }

  static bool get isLoggedIn =>
      _prefs.getBool("isLoggedIn") ?? false;

  static String get uid =>
      _prefs.getString("uid") ?? "";

  static String get username =>
      _prefs.getString("username") ?? "";

  static String get name =>
      _prefs.getString("name") ?? "";

  static Future<void> logout() async {
    await _prefs.clear();
  }


  
}