import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  //pref- value

  static String ISLogin = "false";
  static String ISSeen = "false";
  static String USER_TYPE = "";
  static String USER_FCM_TOKEN = "userFcmToken";
  static String USER_ID = 'user_ID';
  static String USER_FNAME = 'user_fname';
  static String EMAIL = 'email';
  static String USER_NAME = 'name';
  static String USER_MOBILE = 'mobile';
  static String ADMIN_ID = 'admin_id';
  static String PLAN_NAME = 'plan_name';
  static String PLAN_PRICE = 'plan_price';
  static String ROLENAME = 'rolename';
  static String TOKEN = 'remember_token';
  static SpUtil? _instance;
  static Future<SpUtil?> get instance async {
    return await getInstance();
  }

  static SharedPreferences? _spf;

  SpUtil._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<SpUtil?> getInstance() async {
    _instance ??=  SpUtil._();
    if (_spf == null) {
      await _instance?._init();
    }
    return _instance;
  }

  static bool _beforeCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  bool? hasKey(String key) {
    Set<String>? keys = getKeys();
    return keys?.contains(key);
  }

  Set<String>? getKeys() {
    if (_beforeCheck()) return null;
    return _spf?.getKeys();
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf?.get(key);
  }

  getString(String key) {
    if (_beforeCheck()) return null;
    return _spf?.getString(key);
  }

  Future<bool>? putString(String key, String value) {
    if (_beforeCheck()) return null;
    return _spf?.setString(key, value);
  }

  bool? getBool(String key) {
    if (_beforeCheck()) return false;
    return _spf?.getBool(key);
  }

  Future<bool>? putBool(String key, bool value) {
    if (_beforeCheck()) return null;
    return _spf?.setBool(key, value);
  }

  int? getInt(String key) {
    if (_beforeCheck()) return null;
    return _spf?.getInt(key);
  }

  Future<bool>? putInt(String key, int value) {
    if (_beforeCheck()) return null;
    return _spf?.setInt(key, value);
  }

  double? getDouble(String key) {
    if (_beforeCheck()) return null;
    return _spf?.getDouble(key);
  }

  Future<bool>? putDouble(String key, double value) {
    if (_beforeCheck()) return null;
    return _spf?.setDouble(key, value);
  }

  List<String>? getStringList(String key) {
    return _spf?.getStringList(key);
  }

  Future<bool>? putStringList(String key, List<String> value) {
    if (_beforeCheck()) return null;
    return _spf?.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforeCheck()) return null;
    return _spf?.get(key);
  }

  Future<bool>? remove(String key) {
    if (_beforeCheck()) return null;
    return _spf?.remove(key);
  }

  Future<bool>? clear() {
    if (_beforeCheck()) return null;
    return _spf?.clear();
  }

  clearImportantKeys() {
    remove(USER_ID);
    remove(USER_FNAME);
    remove(USER_NAME);
    remove(USER_MOBILE);
      }
}
