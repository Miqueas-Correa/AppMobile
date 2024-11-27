import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appanimals/models/peces/fishes_model.dart';

class FishesService {
  static const String apiUrl = 'https://66f21a344153791915530b67.mockapi.io/api/v1/peces';

  static Future<List<Fishes>> fetchFishes() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Fishes> fishes = data.map((json) => Fishes.fromJson(json)).toList();

        final prefs = await SharedPreferences.getInstance();

        for (var fishes in fishes) {
          fishes.favorite = prefs.getBool(fishes.id) ?? false;
          fishes.stars = prefs.getDouble('${fishes.id}_rating') ?? 0.0;
        }

        return fishes;
      } else {
        throw Exception('Falló al cargar peces');
      }
    } catch (e) {
      throw Exception('Falló al cargar peces: $e');
    }
  }
}
