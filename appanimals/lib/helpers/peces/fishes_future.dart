import 'dart:convert';
import 'package:appanimals/models/peces/list_fishes_model.dart';
import 'package:appanimals/models/peces/fishes_model.dart';
import 'package:http/http.dart' as http;

List<Fishes> activeSearch = [];
String? lastQuery;

Future<Fishes?> futureFishesById(int id) async {
  try {
    final url = Uri.https(
        '66f21a344153791915530b67.mockapi.io', 
        '/api/v1/peces/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Fishes.fromJson(json.decode(response.body));
    } else {
      print('Error en el servicio: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error al realizar el request: $e');
    return null;
  }
}

Future<List<Fishes>?> futureFishesList([int page = 1, int limit = 10]) async {
  final url = Uri.https(
    '66f21a344153791915530b67.mockapi.io',
    '/api/v1/peces', 
    {'page': '$page', 'limit': '$limit'}
  );
  final response = await http.get(url);
  return fishesFromJson(response.body);
}

Future<List<Fishes>?> searchFishes(query,
    [int page = 1, int limit = 10]) async {
  print('$query  $lastQuery');

  // ignore: unnecessary_null_comparison, prefer_is_empty
  if (activeSearch != null && activeSearch.length > 0 && lastQuery == query) {
    print('abort search , return activeSearch');
    return activeSearch;
  }

  if (query == '' || query == null || query.toString().length < 3) {
    print('abort search $query');
    return null;
  }

  final url = Uri.https(
      '66f21a344153791915530b67.mockapi.io',
      '/api/v1/peces', 
      {'page': '$page', 'limit': '$limit', 'filter': '$query'});
  final response = await http.get(url);
  print('searchPeople request');
  activeSearch = fishesFromJson(response.body);
  lastQuery = query;
  return activeSearch;
}

void clearActiveSearch() {
  activeSearch = [];
  lastQuery = '';
}