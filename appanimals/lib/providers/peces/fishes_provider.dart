import 'package:flutter/material.dart';
import 'package:appanimals/models/peces/fishes_model.dart';
import 'package:appanimals/services/peces/fishes_service.dart';


class FishesProvider with ChangeNotifier {
  List<Fishes> _listFishes = [];
  List<Fishes> get listCFishes => _listFishes;

  // Método para cargar los cocodrilos desde la API
  Future<void> loadFishes() async {
    try {
      final fishes = await FishesService.fetchFishes();
      _listFishes = fishes;
      notifyListeners(); // Notificar a los widgets que escuchan el cambio
    } catch (e) {
      print('Error: $e');
    }
  }
}
