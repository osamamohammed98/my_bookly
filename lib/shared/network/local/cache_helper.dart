import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required bool value,
  }) async {
    return await sharedPreferences.setBool("isDark", value);
  }

  static bool getBoolean() {
    return sharedPreferences.getBool("isDark") ?? false;
  }

  static Future<bool> putOnBoarding({
    required bool value,
  }) async {
    return await sharedPreferences.setBool("isOnBoarding", value);
  }

  static bool getOnBoarding() {
    return sharedPreferences.getBool("isOnBoarding") ?? false;
  }

  static Future<bool> putOnLogin({
    required bool value,
  }) async {
    return await sharedPreferences.setBool("isLogin", value);
  }

  static bool getOnLogin() {
    return sharedPreferences.getBool("isLogin") ?? false;
  }

  static Future<bool> saveUserId({required String value}) async {
    return await sharedPreferences.setString("userId", value);
  }

  static String getUserId() {
    return sharedPreferences.getString("userId") ?? FirebaseAuth.instance.currentUser?.uid ??"";
  }

  // static Future<bool> putUserData({
  //   required String value,
  // }) async {
  //   return await sharedPreferences.setString("userData", value);
  // }
  //
  // static UserData getUserData() {
  //   var userData = sharedPreferences.getString("userData") ?? "";
  //   var map = jsonDecode(userData);
  //   return UserData.fromJson(map);
  // }

  static Future<void> clear() async {
    await sharedPreferences.remove("userData");
    await sharedPreferences.remove("userId");
    await sharedPreferences.remove("isLogin");
  }
}
