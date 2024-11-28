import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isLightMode = true; 

  // Getter que devuelve el tema según el valor de _isLightMode
  ThemeData get currentTheme {
    return _isLightMode ? ThemeData.light() : ThemeData.dark();
  }

  // Método para alternar entre tema claro y oscuro
  void toggleTheme() {
    _isLightMode = !_isLightMode;
    notifyListeners();  // Notifica a los listeners que el tema ha cambiado
  }

  // Métodos para establecer explícitamente el tema claro o oscuro
  void setLight() {
    _isLightMode = true;
    notifyListeners();
  }

  void setDark() {
    _isLightMode = false;
    notifyListeners();
  }
}
