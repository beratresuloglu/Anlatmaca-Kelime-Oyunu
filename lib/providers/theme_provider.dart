import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  static const String themeKey = "theme_mode";

  ThemeProvider() {
    _loadTheme(); // provider oluştuğunda kaydedilen temayı yükle
  }

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    _saveTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(themeKey) ?? 0; // 0=light, 1=dark
    _themeMode = themeIndex == 1 ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themeKey, _themeMode == ThemeMode.dark ? 1 : 0);
  }
}
