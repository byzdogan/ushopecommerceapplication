import 'package:flutter/cupertino.dart';
import 'package:ushopecommerceapplication/services/dark_theme_prefs.dart';

class DarkThemeProvider with ChangeNotifier { //changleri takip eder
  DarkThemePrefs darkThemePrefs = DarkThemePrefs();
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners(); //ChangeNotifier'a değişiklik olduğunu iletiyor
  }

}