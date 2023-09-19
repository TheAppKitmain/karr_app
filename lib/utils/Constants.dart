
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF8C52FF);
  static const Color blue = Color(0xFF5A9FD6);
  static const Color yellow = Color(0xFFFFB400);
  static const Color pink = Color(0xFFFF6F73);
  static const Color accentColor = Color(0xFF18D092);
  static const Color textColor = Color(0xFF333333);
  static const Color black = Color(0xFF000000);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color white = Color(0xFFFFFFFF);
}


class SharedStorage {
  Future<void> saveStringToLocalStorage(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String?> getStringFromLocalStorage(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveBoolToLocalStorage(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<bool?> getBoolFromLocalStorage(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> saveIntToLocalStorage(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  Future<int?> getIntFromLocalStorage(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }
}

// Add more custom color constants as needed
