import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(CapanemaFlagApp());
}

class CapanemaFlagApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Capanema Flag App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
