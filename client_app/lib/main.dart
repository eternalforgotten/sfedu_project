import 'package:client_app/ui/main_menu_page/main_menu_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealTime',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xFFFA7022),
        accentColor: Color(0xFF0C2944),
        cardColor: Color(0xFFF5F7FE),
      ),
      home: MainMenuPage()
    );
  }
}
