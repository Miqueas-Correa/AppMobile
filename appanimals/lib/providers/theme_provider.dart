import 'package:flutter/material.dart';
import 'package:appanimals/themes/default_theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isLightMode = true; // Controla si es tema claro o oscuro

  // Getter para obtener el tema actual
  ThemeData get currentTheme {
    return _isLightMode ? DefaultTheme.lightTheme : DefaultTheme.darkTheme;
  }

  // Método para alternar entre temas
  void toggleTheme() {
    _isLightMode = !_isLightMode;
    notifyListeners(); // Notificar a los listeners (Widgets que están escuchando este cambio)
  }

  // Métodos para establecer directamente el tema claro u oscuro
  void setLight() {
    _isLightMode = true;
    notifyListeners();
  }

  void setDark() {
    _isLightMode = false;
    notifyListeners();
  }
}
