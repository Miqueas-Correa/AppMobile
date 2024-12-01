import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appanimals/models/crocodiles/crocodiles_model.dart';

class CrocodilesService {
  static const String apiUrl = 'https://66d0f21f181d059277e01d3c.mockapi.io/api/v1/crocodiles';

  // Método estático para obtener los cocodrilos desde la API

  static Future<List<Crocodile>> fetchCrocodiles() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Decodificar los datos de la API
        List<dynamic> data = json.decode(response.body);
        List<Crocodile> crocodiles = data.map((json) => Crocodile.fromJson(json)).toList();

        // Sincronizar favoritos y estrellas con SharedPreferences
        final prefs = await SharedPreferences.getInstance();

        for (var crocodile in crocodiles) {
          // Obtener los valores almacenados localmente
          crocodile.favorite = prefs.getBool(crocodile.id) ?? false;
          crocodile.stars = prefs.getDouble('${crocodile.id}_rating') ?? 0.0;
        }

        return crocodiles;
      } else {
        throw Exception('Failed to load crocodiles');
      }
    } catch (e) {
      throw Exception('Failed to load crocodiles: $e');
    }
  }
}
