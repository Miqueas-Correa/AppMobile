import 'dart:convert';
import 'package:appanimals/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appanimals/models/cats/cats_model.dart';

class CatsService {
  static Future<List<Cats>> fetchCats() async {
    try {
      final response =
          await http.get(Uri.parse('${Config.apiUrl}/api/v1/cats'));
      print('Status code: ${response.statusCode}');
      print('Respuesta: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse is! Map<String, dynamic> ||
            !decodedResponse.containsKey('data')) {
          throw Exception('Formato de respuesta de API no valido');
        }

        List<dynamic> data = decodedResponse['data'];
        List<Cats> cats = data.map((json) => Cats.fromJson(json)).toList();

        final prefs = await SharedPreferences.getInstance();

        for (var cat in cats) {
          cat.favorite = prefs.getBool(cat.id) ?? false;
          cat.stars = prefs.getDouble('${cat.id}_rating') ?? 0.0;
        }

        return cats;
      } else {
        throw Exception('No se pudieron cargar gatos. Codigo de estado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('No se pudieron cargar gatos: $e');
    }
  }
  // metodo paara guardar fav
  static Future<void> toggleFavorite(String catId, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(catId, isFavorite);
  }

  //meotodo para guardar las estreklas
  static Future<void> saveRating(String catId, double rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('${catId}_rating', rating);
  }
}