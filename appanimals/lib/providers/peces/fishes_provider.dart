import 'package:appanimals/models/peces/fishes_model.dart';
import 'package:appanimals/services/fishes_services.dart';
import 'package:flutter/material.dart';


class FishesProvider with ChangeNotifier {
  List<Fishes> _listFishes = [];
  List<Fishes> get listFishes => _listFishes;

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