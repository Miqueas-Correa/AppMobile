// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:appanimals/themes/default_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData temaActual;

  ThemeProvider({required bool isLightMode})
    :temaActual = 
        (isLightMode) ? DefaultTheme.lightTheme : DefaultTheme.lightTheme;

  setLight() {
    print('setLight');
    temaActual = DefaultTheme.lightTheme;
    notifyListeners();
  }

  setDark() {
    print('setLight');
    temaActual = DefaultTheme.darkTheme;
    notifyListeners();
  }
}