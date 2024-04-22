import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //To Get Data Is Save
  dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  dynamic haveData({
    required String key,
  }) {
    return sharedPreferences!.containsKey(key);
  }

  //To Save Data
  Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);

    return sharedPreferences!.setString(key, value);
  }

  Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }

  clearData() async {
    await sharedPreferences!.clear();
  }
}