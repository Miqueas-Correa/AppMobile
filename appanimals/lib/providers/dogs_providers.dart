import 'package:appanimals/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/models/dogs_model.dart';

class DogsProviders with ChangeNotifier {
  List<DogsModel> _listDogs = [];
  List<DogsModel> get listDogs => _listDogs;

  // Método para cargar los perros desde la API
  Future<void> loadDogs() async {
    try {
      final dogs = await ApiService.fetchAllDataByCategory('dogs');
      _listDogs = dogs;
      notifyListeners(); // Notificar a los widgets que escuchan el cambio
    } catch (e) {
      print('Error: $e');
    }
  }
}
