import 'package:appanimals/models/structs/cats_struct.dart';
import 'package:appanimals/models/structs/crocodiles_struct.dart';
import 'package:appanimals/models/structs/fishes_struct.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/service/api_service.dart';
import 'package:appanimals/models/structs/dogs_struct.dart';

class AnimalService {
  static Future<Map<String, dynamic>?> fetchAnimalData({
    required String category,
    required String id,
    required Function(String) showSnackBar,
    required Function(bool) setLoading,
  }) async {
    setLoading(true);
    try {
      final data = await ApiService.fetchDataByCategoryAndId(category, id);
      if (data['msg'] == 'Ok' && data['data'] != null) {
        setLoading(false);
        return data['data'];
      } else {
        showSnackBar('No se encontraron datos para este ID.');
        setLoading(false);
        return null;
      }
    } catch (e) {
      showSnackBar('Error al conectarse: $e');
      setLoading(false);
      return null;
    }
  }

  static Widget buildAnimalCard({
    required Map<String, dynamic>? animalData,
    required String category,
    required bool isFavorite,
    required Function() toggleFavorite,
  }) {
    if (animalData == null) return const SizedBox.shrink();

    switch (category) {
      case 'dogs':
        return DogStruct(animalData, isFavorite, toggleFavorite);
      case 'cats':
        return CatStruct(animalData, isFavorite, toggleFavorite);
      case 'crocodiles':
        return CrocodileStruct(animalData, isFavorite, toggleFavorite);
      case 'fish':
        return FishesStruct(animalData, isFavorite, toggleFavorite);
      default:
        return const Text('Categoría no soportada.');
    }
  }
}
