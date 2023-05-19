import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
      //0A1931  // white yellow 0xFFFCF8EC
      isDarkTheme ? const Color(0xff0a0a0a) : const Color(0xFFFFFFFF),
      primaryColor: Colors.blue,
      colorScheme: ThemeData().colorScheme.copyWith(
        secondary:
        isDarkTheme ? const Color(0xff6b6a6a) : const Color(0xFFE8FDFD),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      cardColor:
      isDarkTheme ? const Color(0xff1a1a1a) : const Color(0xFFF2FDFD),
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      //BuildContext context kısmını silince, buttonTheme'den buraya kadar da sildi
    );
  }
}