import 'package:appanimals/models/cats/cats_model.dart';
import 'package:appanimals/service/cats_service.dart';
import 'package:flutter/material.dart';

class CatsProvider with ChangeNotifier {
  List<Cats> _listCats = [];
  List<Cats> get listCats => _listCats;

  Future<void> loadCats() async {
    try {
      final cats = await CatsService.fetchCats();
      _listCats = cats;
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }
}
