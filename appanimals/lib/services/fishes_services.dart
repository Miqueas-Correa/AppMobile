import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appanimals/models/peces/fishes_model.dart';

class FishesService {
  static const String apiUrl = 'https://66f21a344153791915530b67.mockapi.io/api/v1/peces';

  // Método estático para obtener los cocodrilos desde la API

  static Future<List<Fishes>> fetchFishes() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Decodificar los datos de la API
        List<dynamic> data = json.decode(response.body);
        List<Fishes> fishes = data.map((json) => Fishes.fromJson(json)).toList();

        // Sincronizar favoritos y estrellas con SharedPreferences
        final prefs = await SharedPreferences.getInstance();

        for (var fishes in fishes) {
          // Obtener los valores almacenados localmente
          fishes.favorite = prefs.getBool(fishes.id) ?? false;
          fishes.stars = prefs.getDouble('${fishes.id}_rating') ?? 0.0;
        }

        return fishes;
      } else {
        throw Exception('Fallo al cargar los peces');
      }
    } catch (e) {
      throw Exception('Fallo al cargar los peces: $e');
    }
  }
}