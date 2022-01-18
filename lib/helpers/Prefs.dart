import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future set(String name, value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    if (value == null) return instance.remove(name);
    return instance.setString(name, value);
  }

  static Future get(String name) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getString(name);
  }

  static Future clear(String name) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.remove(name);
  }


}
