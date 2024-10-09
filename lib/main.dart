import 'package:contact_diary_app/routes/all_routes.dart';
import 'package:contact_diary_app/utils/globals.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blueAccent,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          bodyLarge: TextStyle(fontSize: 16),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      darkTheme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          bodyLarge: TextStyle(fontSize: 16),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      themeMode: ThemeMode.light,
      routes: AppRoutes.allRoutes,
    );
  }
}
