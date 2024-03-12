
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF8c52ff);
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
//*********************************************************************************

// *************************************************************************************

class ToastUtils {
  static void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }
}
//*********************************************************************************// *************************************************************************************

class CapitalWOrd {
 static String capitalizeWords(String input) {
    // Split the input string into individual words
    List<String> words = input.split(' ');

    // Capitalize the first letter of each word
    List<String> capitalizedWords = words.map((word) {
      // Ensure the word is not empty
      if (word.isNotEmpty) {
        // Capitalize the first letter and concatenate with the rest of the word
        return '${word[0].toUpperCase()}${word.substring(1)}';
      } else {
        return '';
      }
    }).toList();

    // Join the capitalized words back into a single string
    String result = capitalizedWords.join(' ');

    return result;
  }
 static String capitalizeWithNumbers(String input) {
   // Convert each character to uppercase if it's a letter
   String result = input.runes.map((int charCode) {
     // Convert character code to a string
     String char = String.fromCharCode(charCode);

     // Check if the character is a letter
     if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
       // If it's a letter, convert it to uppercase
       return char.toUpperCase();
     } else {
       // If it's not a letter (e.g., number or special character), leave it unchanged
       return char;
     }
   }).join('');

   return result;
 }
}
//*********************************************************************************

Future<void> saveRecentActivity(String activity) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> activities = prefs.getStringList('recent_activities') ?? [];
    String currentDate = DateFormat('dd MMM yy').format(DateTime.now());
    String timestamp = DateFormat('hh:mm a').format(DateTime.now()); // Format current time
    String activityWithTime = '$activity / $currentDate: / $timestamp'; // Combine activity with time
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
