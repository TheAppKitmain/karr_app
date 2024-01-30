
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF8C52FF);
  static const Color blue = Color(0xFF5A9FD6);
  static const Color yellow = Color(0xFFFFB400);
  static const Color pink = Color(0xFFFF6F73);
  static const Color accentColor = Color(0xFF18D092);
  static const Color textColor = Color(0xFF333333);
  static const Color black = Color(0xFF000000);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color backgroundColorOvwhite = Color(0xABF1EDED);
  static const Color white = Color(0xFFFFFFFF);
}


Future<void> saveRecentActivity(String activity) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> activities = prefs.getStringList('recent_activities') ?? [];
    String timestamp = DateFormat('hh:mm a').format(DateTime.now()); // Format current time
    String activityWithTime = '$activity \n $timestamp'; // Combine activity with time
    activities.add(activityWithTime); // Insert at the beginning of the list
    // Keep only the latest 10 activities
    // activities = activities.sublist(0, 10);
    await prefs.setStringList('recent_activities', activities);
  } catch (e) {
    print('Error saving recent activity: $e');
  }
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
