import 'package:flutter/foundation.dart';
import 'package:appanimals/models/list_fishes_model.dart';
import 'package:appanimals/models/fishes_model.dart';
import 'package:http/http.dart' as http;

class FishesProvider extends ChangeNotifier {
  List<Fishes> listFishes = [];

  FishesProvider() {
    print('FishProvider......');
    getFishes();
  }

  getFishes([int page = 1, int limit = 54]) async {
    try {
      print('realizando peticion a MockAPI Animales......');
      final url = Uri.https('66f21a344153791915530b67.mockapi.io', '/api/v1/peces', {'page': '$page', 'limit': '$limit'});
      print(url);
      final response = await http.get(url);
      print('response ${response.statusCode}');

      if (response.statusCode == 200) {
        listFishes = fishesFromJson(response.body);
        print('Datos de peces: $listFishes'); // Verifica los datos recibidos
      } else {
        print('Error en el servicio: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al realizar el request: $e');
    }
    notifyListeners();
  }
}
