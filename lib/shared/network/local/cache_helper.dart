import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences? sharedPreferences;

  static init()async
  {
    sharedPreferences= await SharedPreferences.getInstance();

  }

  static Future<bool> SetData({
    required String key,
    required dynamic value
  })async
  {
    return await sharedPreferences!.setBool(key, value);

  }

  static bool? GetData({
    required String key,
  })
  {
    return sharedPreferences!.getBool(key);
  }
}