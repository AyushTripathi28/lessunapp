import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  static Future<bool> setUid(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("uid", value);
  }

  static Future<String?> getUid(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
