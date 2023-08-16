import 'package:flutter/material.dart';
import 'package:pet_pals/presentation/themes/theme_options.dart';
import 'package:pet_pals/presentation/themes/theme_preferences.dart';

class ThemeDataManager extends ChangeNotifier {
  late ThemePreferences _themePreferences;
  late ThemeOptions _currentTheme;

  String get currentThemeName => _currentTheme.key;

  ThemeData get currentTheme {
    switch (_currentTheme) {
      case ThemeOptions.defaultTheme:
        return _getDefaultTheme();
      case ThemeOptions.greenTheme:
        return _getGreenTheme();
    }
  }

  ThemeData get currentDarkTheme {
    switch (_currentTheme) {
      case ThemeOptions.defaultTheme:
        return _getDefaultDarkTheme();
      case ThemeOptions.greenTheme:
        return _getGreenDarkTheme();
    }
  }

  ThemeDataManager() {
    _currentTheme = ThemeOptions.defaultTheme;
    _themePreferences = ThemePreferences();
    _getPreferences();
  }

  set theme(ThemeOptions selectedTheme) {
    _currentTheme = selectedTheme;
    _themePreferences.setTheme(selectedTheme);
    notifyListeners();
  }

  _getPreferences() async {
    _currentTheme = await _themePreferences.getTheme();
    notifyListeners();
  }

  ThemeData _getDefaultTheme() {
    return ThemeData(
      fontFamily: "Manrope",
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(180, 95, 6, 1),
        background: const Color.fromRGBO(245, 232, 216, 1),
      ),
      useMaterial3: true,
    );
  }

  ThemeData _getDefaultDarkTheme() {
    return ThemeData(
      fontFamily: "Manrope",
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color.fromARGB(255, 68, 36, 2),
        background: Color.fromARGB(255, 61, 35, 4),
      ),
      useMaterial3: true,
    );
  }

  ThemeData _getGreenTheme() {
    return ThemeData(
      fontFamily: "Manrope",
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 44, 103, 46),
        background: const Color.fromARGB(255, 165, 243, 167),
      ),
      useMaterial3: true,
    );
  }

  ThemeData _getGreenDarkTheme() {
    return ThemeData(
      fontFamily: "Manrope",
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color.fromARGB(255, 4, 52, 5),
        background: Color.fromARGB(255, 3, 35, 4),
      ),
      useMaterial3: true,
    );
  }
}