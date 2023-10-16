

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kaar/controller/login/Login.dart';
import 'package:kaar/controller/home/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for using SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final String username = prefs.getString('name') ?? '';
  final String id = prefs.getString('userid') ?? '';
  final String carnumber = prefs.getString('license_number') ?? '';
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    initialRoute: id.isNotEmpty ? '/home' : '/login',
    username: username,

    carnumber: carnumber,
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final String username;

  final String carnumber;

  MyApp({
    required this.initialRoute,
    required this.username,

    required this.carnumber,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => HomeScreen(username, carnumber),
      },
    );
  }
}

