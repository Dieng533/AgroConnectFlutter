import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'core/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroConnect',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}









