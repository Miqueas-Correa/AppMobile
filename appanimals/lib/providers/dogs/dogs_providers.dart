import 'package:appanimals/models/dogs_model.dart';
import 'package:appanimals/service/dogs_service.dart';
import 'package:flutter/material.dart';

class DogsProviders with ChangeNotifier {
  List<DogsModel> _listDogs = [];
  List<DogsModel> get listDogs => _listDogs;

  Future<void> loadDogs() async {
    try {
      final dogs = await DogsService.fetchDogs();
      _listDogs = dogs;
      notifyListeners(); // Notificar a los widgets que escuchan el cambio
    } catch (e) {
      print('Error: $e');
    }
  }
}
