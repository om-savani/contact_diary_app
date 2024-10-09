import 'package:flutter/material.dart';

class Globals {
  static ThemeMode theme = ThemeMode.dark;
  static String? name, number, email;
  static themeMode(bool ison) {
    setstate() {
      theme = ison ? ThemeMode.light : ThemeMode.dark;
    }
  }
}
