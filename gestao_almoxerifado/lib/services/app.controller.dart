import 'package:flutter/material.dart';

class AppController extends ChangeNotifier{

  bool isDarkTheme = false;
  changeTheme(){
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  ThemeMode get themeMode =>
      isDarkTheme ? ThemeMode.dark : ThemeMode.light;
}
