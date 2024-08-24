import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  String _currentLanguage = 'en';

  // Getter for dark mode
  bool get isDarkMode => _isDarkMode;

  // Getter for current language
  String get currentLanguage => _currentLanguage;

  // Method to set dark mode
  void setDarkMode(bool value) {
    if (_isDarkMode != value) {
      _isDarkMode = value;
      notifyListeners();
    }
  }

  // Method to set language
  void setLanguage(String languageCode) {
    if (_currentLanguage != languageCode) {
      _currentLanguage = languageCode;
      notifyListeners();
    }
  }

  // Method to get splash image based on current theme
  String getSplashImage() {
    return _isDarkMode
        ? "assets/images/splash_background_dark.png"
        : "assets/images/splash_background.png";
  }

  // Method to check if the current theme is dark
  bool isDark() {
    return _isDarkMode;
  }

  // Method to check if the current language is Arabic
  bool isArabic() {
    return _currentLanguage == "ar";
  }
}
