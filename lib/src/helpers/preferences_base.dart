import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth/login_model.dart';

class Prefs {
  static const String KEY_AUTH = 'KEY_AUTH';
  static const String KEY_TOKEN = 'KEY_TOKEN';
  static const String KEY_HAS_INIT = 'KEY_HAS_INIT';

  // AUTH
  static Future<LoginModel> get auth async {
    String pref = await PreferencesHelper.getString(KEY_AUTH);
    if (pref == '') return null;
    dynamic json = jsonDecode(pref);
    LoginModel result = LoginModel.fromJson(json);
    return result;
  }

  static Future setAuth(LoginModel value) async {
    if (value == null) return PreferencesHelper.removal(KEY_AUTH);
    return PreferencesHelper.setString(KEY_AUTH, json.encode(value));
  }

  // TOKEN
  static Future<String> get token => PreferencesHelper.getString(KEY_TOKEN);
  static Future setToken(String value) =>
      PreferencesHelper.setString(KEY_TOKEN, value);

  // INIT
  static Future<bool> get hasInit => PreferencesHelper.getBool(KEY_HAS_INIT);
  static Future setHasInit(bool value) =>
      PreferencesHelper.setBool(KEY_HAS_INIT, value);
}

class PreferencesHelper {
  static Future<bool> getBool(String key) async {
    final p = await prefs;
    return p.getBool(key) ?? false;
  }

  static Future setBool(String key, bool value) async {
    final p = await prefs;
    return p.setBool(key, value);
  }

  static Future<int> getInt(String key) async {
    final p = await prefs;
    return p.getInt(key) ?? 0;
  }

  static Future setInt(String key, int value) async {
    final p = await prefs;
    return p.setInt(key, value);
  }

  static Future<String> getString(String key) async {
    final p = await prefs;
    return p.getString(key) ?? '';
  }

  static Future setString(String key, String value) async {
    final p = await prefs;
    return p.setString(key, value);
  }

  static Future<double> getDouble(String key) async {
    final p = await prefs;
    return p.getDouble(key) ?? 0.0;
  }

  static Future setDouble(String key, double value) async {
    final p = await prefs;
    return p.setDouble(key, value);
  }

  static Future removal(String key) async {
    final p = await prefs;
    return p.remove(key);
  }

  static Future removeAll() async {
    final p = await prefs;
    return p.clear();
  }

  static Future<List<Widget>> getAllPrefs() async {
    final SharedPreferences thisPrefs = await prefs;
    return thisPrefs
        .getKeys()
        .map<Widget>((key) => ListTile(
              title: Text(key),
              subtitle: Text(thisPrefs.get(key).toString()),
            ))
        .toList(growable: false);
  }

  static Future logout() async {
    final p = await prefs;
    for (String key in p.getKeys()) {
      if (key != 'DEVICE_ID' && key != 'PUSH_TOKEN') {
        p.remove(key);
      }
    }
  }

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
