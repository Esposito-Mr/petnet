// lib/providers/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  // Default to dark theme IN THE CODE
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme(); // Load saved theme preference on initialization
  }

  void setTheme(ThemeMode themeMode) {
    if (_themeMode == themeMode) return; // No change needed
    _themeMode = themeMode;
    _saveTheme(themeMode); // Save the new preference
    notifyListeners(); // IMPORTANT: Notify widgets to rebuild
  }

  // Load theme preference from local storage
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // Read saved preference. If null (first time), default to 'dark'.
    final savedTheme = prefs.getString('theme') ?? 'dark';
    _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    // Notify listeners after loading, in case the saved theme is different
    notifyListeners();
  }

  // Save theme preference to local storage
  Future<void> _saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', themeMode == ThemeMode.dark ? 'dark' : 'light');
  }
}