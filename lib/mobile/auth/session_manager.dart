import 'package:shared_preferences/shared_preferences.dart';

class OfficerSession {
  static late SharedPreferences _prefs;

  //==========================================================
  // Initialize
  //==========================================================

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    uid = _prefs.getString("uid") ?? "";

    name = _prefs.getString("name") ?? "";

    email = _prefs.getString("email") ?? "";

    mobile = _prefs.getString("mobile") ?? "";

    loginType = _prefs.getString("loginType") ?? "";

    badgeId = _prefs.getString("badgeId") ?? "";

    rank = _prefs.getString("rank") ?? "";

    stationId = _prefs.getString("stationId") ?? "";

    stationName = _prefs.getString("stationName") ?? "";

    shift = _prefs.getString("shift") ?? "";

    isLoggedIn = _prefs.getBool("isLoggedIn") ?? false;
  }

  //==========================================================
  // Common
  //==========================================================

  static bool isLoggedIn = false;

  static String uid = "";

  static String name = "";

  static String email = "";

  static String mobile = "";

  static String loginType = "";

  //==========================================================
  // Officer
  //==========================================================

  static String badgeId = "";

  static String rank = "";

  static String stationId = "";

  static String stationName = "";

  static String shift = "";

  //==========================================================
  // Save Login
  //==========================================================

  static Future<void> setLogin({
    required String uid,
    required String name,
    required String email,
    required String mobile,
    required String loginType,
    String badgeId = "",
    String rank = "",
    String stationId = "",
    String stationName = "",
    String shift = "",
  }) async {
    OfficerSession.uid = uid;
    OfficerSession.name = name;
    OfficerSession.email = email;
    OfficerSession.mobile = mobile;
    OfficerSession.loginType = loginType;

    OfficerSession.badgeId = badgeId;
    OfficerSession.rank = rank;
    OfficerSession.stationId = stationId;
    OfficerSession.stationName = stationName;
    OfficerSession.shift = shift;

    isLoggedIn = true;

    await _prefs.setBool("isLoggedIn", true);

    await _prefs.setString("uid", uid);
    await _prefs.setString("name", name);
    await _prefs.setString("email", email);
    await _prefs.setString("mobile", mobile);
    await _prefs.setString("loginType", loginType);

    await _prefs.setString("badgeId", badgeId);
    await _prefs.setString("rank", rank);
    await _prefs.setString("stationId", stationId);
    await _prefs.setString("stationName", stationName);
    await _prefs.setString("shift", shift);
  }

  //==========================================================
  // Logout
  //==========================================================

  static Future<void> logout() async {
    uid = "";
    name = "";
    email = "";
    mobile = "";
    loginType = "";

    badgeId = "";
    rank = "";
    stationId = "";
    stationName = "";
    shift = "";

    isLoggedIn = false;

    await _prefs.clear();
  }
}