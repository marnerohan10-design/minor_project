import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const SmartQuizApp());
}

class SmartQuizApp extends StatelessWidget {
  const SmartQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    const brandColor = Color(0xFF176B5B);

    return MaterialApp(
      title: 'Smart Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: brandColor),
        scaffoldBackgroundColor: const Color(0xFFF5F7F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F7F5),
          foregroundColor: Color(0xFF17352E),
          centerTitle: false,
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
