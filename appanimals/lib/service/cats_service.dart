import 'dart:convert';
import 'package:appanimals/models/cats_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class CatsService {
  // URL de la API (modifica esta URL según tu endpoint de gatos)
  static const String apiUrl = 'https://66f21e0f415379191553149f.mockapi.io/api/v1/cats';

  // Método estático para obtener la lista de gatos desde la API
  static Future<List<CatsModel>> fetchCats() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Decodificar los datos de la API
        List<dynamic> data = json.decode(response.body);
        List<CatsModel> cats = data.map((json) => CatsModel.fromJson(json)).toList();

        // Sincronizar favoritos y calificaciones con SharedPreferences
        final prefs = await SharedPreferences.getInstance();

        for (var cat in cats) {
          // Recuperar valores almacenados localmente
          cat.favorito = prefs.getBool(cat.id) ?? false;
          cat.estrella = prefs.getDouble('${cat.id}_rating') ?? 0.0;
        }

        return cats;
      } else {
        throw Exception('Failed to load cats');
      }
    } catch (e) {
      throw Exception('Failed to load cats: $e');
    }
  }

  
}
