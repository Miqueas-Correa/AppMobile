import 'dart:convert';
import 'package:appanimals/models/cats/cats_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CatsService {
  // url de la mockapi -> https://66f21e0f415379191553149f.mockapi.io/api/v1/cats
  static const String apiUrl = 'https://66f21e0f415379191553149f.mockapi.io/api/v1/cats';

  static Future<List<Cat>> fetchCats() async {
  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      // Decodifico los datos de la API
      List<dynamic> data = json.decode(response.body);
      List<Cat> cats = data.map((json) {
        return Cat.fromJson({
          'id': json['id'] ?? '', 
          'nombre': json['nombre'] ?? '', 
          'raza': json['raza'] ?? '', 
          'color': json['color'] ?? '', 
          'avatar': json['avatar'] ?? '', 
          'estrella': (json['estrella'] != null) ? json['estrella'].toDouble() : 0.0,
          'favorito': json['favorito'] ?? false, 
        });
      }).toList();

      // Sincronizoa favoritos y calificaciones con SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      for (var cat in cats) {
        cat.favorito = prefs.getBool(cat.id) ?? false;
        cat.estrella = prefs.getDouble('${cat.id}_rating') ?? 0.0;
      }

      return cats;
    } else {
      throw Exception('Fallo al cargar los gatos');
    }
  } catch (e) {
    throw Exception('Fallo al cargar los gatos: $e');
  }
}


}
