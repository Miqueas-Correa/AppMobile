import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appanimals/models/cats/cats_model.dart';

class CatsService {
  static Future<List<Cats>> fetchCats() async {
    try {
      final response = await http.get(
          Uri.parse('https://66f21e0f415379191553149f.mockapi.io/api/v1/cats'));
      print('Status code: ${response.statusCode}');
      print('Respuesta: ${response.body}');

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((cat) => Cats.fromJson(cat)).toList();
      } else {
        throw Exception('Error en la petición: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en fetchCats: $e');
      throw Exception('Error al cargar los gatos: $e');
    }
  }
}
