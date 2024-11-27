import 'dart:convert'; // para decodificar JSON
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  /// Método para obtener datos por categoría e ID
  Future<dynamic> fetchDataByCategoryAndId(String category, String id) async {
    final url = Uri.parse('$baseUrl/$category/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json
            .decode(response.body); // Decodifica la respuesta en formato JSON
      } else {
        throw Exception('Error al obtener datos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectarse: $e');
    }
  }
}
