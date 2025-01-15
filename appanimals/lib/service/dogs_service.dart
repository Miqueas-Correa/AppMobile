import 'dart:convert';
import 'package:appanimals/models/dogs_model.dart';
import 'package:appanimals/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DogsService {
  static final String apiUrl = '${Config.apiUrl}/api/v1/dogs';

  static Future<List<DogsModel>> fetchDogs() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Decodificar los datos de la API
        final decodedResponse = json.decode(response.body);
        if (decodedResponse is! Map<String, dynamic> ||
            !decodedResponse.containsKey('data')) {
          throw Exception('Invalid API response format');
        }

        List<dynamic> data = decodedResponse['data'];
        List<DogsModel> dogs =
            data.map((json) => DogsModel.fromJson(json)).toList();

        // Sincronizar favoritos y estrellas con SharedPreferences
        final prefs = await SharedPreferences.getInstance();

        for (var dog in dogs) {
          // Obtener los valores almacenados localmente
          dog.favorite = prefs.getBool(dog.id) ?? false;
          dog.stars = prefs.getDouble('${dog.id}_rating') ?? 0.0;
        }

        return dogs;
      } else {
        throw Exception(
            'Failed to load dogs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load dogs: $e');
    }
  }
}
