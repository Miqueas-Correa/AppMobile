import 'package:flutter/material.dart';
import 'package:appanimals/models/peces/fishes_model.dart';
import 'package:appanimals/service/fishes_service.dart';

class FishesProvider with ChangeNotifier {
  List<Fishes> _listFishes = [];
  List<Fishes> get listFishes => _listFishes;

  Future<void> loadFishes() async {
    try {
      final fishes = await FishesService.fetchFishes();
      _listFishes = fishes;
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }
}
