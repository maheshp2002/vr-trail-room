import 'package:flutter/material.dart';
import 'homepage/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Clothing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, // Light theme
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Dark theme
      ),
      home: HomePage(),
    );
  }
}
