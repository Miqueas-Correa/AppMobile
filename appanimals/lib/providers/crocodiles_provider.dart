import 'package:flutter/material.dart';
import 'package:appanimals/models/crocodiles_model.dart';
import 'package:appanimals/service/crocodiles_service.dart';

class CrocodilesProvider with ChangeNotifier {
  List<Crocodile> _listCrocodiles = [];
  List<Crocodile> get listCrocodiles => _listCrocodiles;

  // Método para cargar los cocodrilos desde la API
  Future<void> loadCrocodiles() async {
    try {
      final crocodiles = await CrocodilesService.fetchCrocodiles();
      _listCrocodiles = crocodiles;
      notifyListeners(); // Notificar a los widgets que escuchan el cambio
    } catch (e) {
      print('Error: $e');
    }
  }
}
