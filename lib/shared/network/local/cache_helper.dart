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
}
