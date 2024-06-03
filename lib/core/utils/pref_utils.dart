//ignore: unused_import    
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;
  static String prefName = "com.sportsslot.app";
  static String isIntro = "${prefName}isIntro";
  static String signIn = "${prefName}signIn";

  PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }




  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }

  static setIsIntro(bool sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isIntro, sizes);
  }

  static getIsIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(isIntro) ?? true;
    return intValue;
  }


  static setIsSignIn(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(signIn, isFav);
  }

  static getIsSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(signIn) ?? true;
  }

  static Future<void> setValue(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences?.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences?.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences?.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPreferences?.setBool(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences?.setStringList(key, value);
    } else {
      // showToast(Strings.prefsError);
    }
  }

  static String getString(String key) {
    return _sharedPreferences?.getString(key) ?? '';
  }

  static int getInt(String key) {
    return _sharedPreferences?.getInt(key) ?? 0;
  }

  static double getDouble(String key) {
    return _sharedPreferences?.getDouble(key) ?? 0;
  }

  static bool getBool(String key) {
    return _sharedPreferences?.getBool(key) ?? false;
  }

  static List<String> getList(String key) {
    return _sharedPreferences?.getStringList(key) ?? [];
  }

  static Future<void> remove(String key) async {
    await _sharedPreferences?.remove(key);
  }
}
    