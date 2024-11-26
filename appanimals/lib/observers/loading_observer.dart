import 'package:flutter/material.dart';
class LoadingObserver extends NavigatorObserver {
  final Function(bool) onPageChanged;

  LoadingObserver(this.onPageChanged);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    onPageChanged(true); // Mostrar la animación al navegar a una nueva pantalla
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    onPageChanged(true); // Mostrar la animación cuando se vuelve a la pantalla anterior
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    onPageChanged(true); // Mostrar la animación cuando una pantalla se elimina
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    onPageChanged(true); // Mostrar la animación cuando se reemplaza una pantalla
  }
}
