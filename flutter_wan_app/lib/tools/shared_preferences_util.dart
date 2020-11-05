import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
//  /// 静态私有实例对象
//  static final _instance = SharedPreferencesUtil._init();
//
//  /// 工厂构造函数 返回实例对象
//  factory SharedPreferencesUtil() => _instance;
//
//  /// SharedPreferences对象
//  static SharedPreferences _storage;
//
//  /// 命名构造函数 用于初始化SharedPreferences实例对象
//  SharedPreferencesUtil._init() {
//    _initStorage();
//  }
//  // 之所以这个没有写在 _init中，是因为SharedPreferences.getInstance是一个异步的方法 需要用await接收它的值
//  _initStorage() async {
//    // 若_不存在 则创建SharedPreferences实例
//    if (_storage == null) _storage = await SharedPreferences.getInstance();
//  }

  static Future<bool> putObject(String key, Object value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value == null ? "" : json.encode(value));
  }

  static Future<T> getObj<T>(String key, T f(Map v)) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String res = prefs.getString(key);
    Map map;
    if (res == null || res.isEmpty) {
      map = null;
    } else {
      map = json.decode(res);
    }

    return map == null ? null : f(map);
  }

  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> putString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value == null ? "" : value);
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<bool> putBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<bool> putInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<double> getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<bool> putDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  static Future<List<String>> getStringList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  static Future<bool> putStringList(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }
}
