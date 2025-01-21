import 'dart:convert';
import 'package:appanimals/models/peces/fishes_model.dart';
import 'package:appanimals/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FishesService {
   static Future<List<Fishes>> fetchFishes() async {
    try {
      final response = 
        await http.get(Uri.parse('${Config.apiUrl}/api/v1/peces'));
      print('Status code: ${response.statusCode}');
      print('Respuesta: ${response.body}');
      
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse is! Map<String, dynamic> ||
            !decodedResponse.containsKey('data')) {
          throw Exception('Formato de respuesta de API no valido');
        }
        List<dynamic> data = decodedResponse['data'];
        List<Fishes> fishes = data.map((json) => Fishes.fromJson(json)).toList();

        final prefs = await SharedPreferences.getInstance();

        for (var fishes in fishes) {
          fishes.favorite = prefs.getBool(fishes.id) ?? false;
          fishes.stars = prefs.getDouble('${fishes.id}_rating') ?? 0.0;
        }

        return fishes;

      } else {
        throw Exception('Failed to load fishes');
      }
    } catch (e) {
      throw Exception('Failed to load fishes: $e');
    }
  }
}
