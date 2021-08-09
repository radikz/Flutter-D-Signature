import 'package:flutter/material.dart';
import 'package:flutter_signature/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        brightness: Brightness.light,
        backgroundColor: const Color(0xFFE5E5E5),
        accentColor: Colors.black,
        accentIconTheme: IconThemeData(color: Colors.white),
        hoverColor: Colors.blueAccent,
        focusColor: Color(0xff0B2512),
        canvasColor: Colors.grey[50],
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
        ),
        highlightColor: Color(0xffFCE192),

      ),
      title: 'Flutter Signature',
      home: HomeScreen(),
    );
  }
}