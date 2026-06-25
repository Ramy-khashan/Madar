// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
class PreferenceUtils {
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance ??= await SharedPreferences.getInstance();
    return _prefsInstance!;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefsInstance!.setBool(key, value);
  }

  bool getBool(String key, [bool defaultValue = false]) {
    return _prefsInstance!.getBool(key) ?? defaultValue;
  }

  Future<bool> setString(String key, String value) async {
    return await _prefsInstance!.setString(key, value);
  }

  String getString(String key, [String defaultValue = '']) {
    return _prefsInstance!.getString(key) ?? defaultValue;
  }

  Future<bool> clear(String key) async {
    return await _prefsInstance!.remove(key);
  }  Future<bool> clearAll() async {
    return await _prefsInstance!.clear();
  }
}
