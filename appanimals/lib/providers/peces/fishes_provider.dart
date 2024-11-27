import 'dart:convert';
import 'package:appanimals/models/peces/fishes_model.dart';
import 'package:appanimals/models/peces/list_fishes_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FishesProvider extends ChangeNotifier {
  List<Fishes> listFishes = [];
  int currentPage = 1;
  bool isLoading = false;

  FishesProvider() {
    print('FishesProvider inicializando');
    // ignore: unnecessary_this
    this.getFishes();
  }

  getFishes([int limit = 10]) async {
    try {
      final url = Uri.https(
        '66f21a344153791915530b67.mockapi.io',
        '/api/v1/peces', 
        {'page': '$currentPage', 'limit': '$limit'});
      isLoading = true;
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("Respuesta de la API: ${response.body}");
        List<Fishes> newFishes = fishesFromJson(response.body);
        
        if (newFishes.isEmpty) {
          print("No se encontraron peces.");
        } else {
          print("Se encontraron ${newFishes.length} peces.");
        }

        listFishes.addAll(newFishes);
        currentPage++;
      
      } else {
        print('Error en el servicio: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al realizar el request: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Fishes?> getFishesById(int id) async {
    try {
      final url = Uri.https(
        '66f21a344153791915530b67.mockapi.io', 
        '/api/v1/peces/$id');
      print(url);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('.....${Fishes.fromJson(json.decode(response.body))}');
        return Fishes.fromJson(json.decode(response.body));
      } else {
        print('Error en el servicio: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error al realizar el request: $e');
      return null;
    }
  }
}

