import 'package:flutter/material.dart';
import 'package:appanimals/models/categories_model.dart';
import 'package:appanimals/providers/gatos/cats_provider.dart';
import 'package:appanimals/providers/dogs/dogs_providers.dart';
import 'package:appanimals/providers/peces/fishes_provider.dart';
import 'package:appanimals/providers/cocodrilos/crocodiles_provider.dart';

class AnimalsProvider with ChangeNotifier {
  final CatsProvider catsProvider;
  final DogsProviders dogsProviders;
  final FishesProvider fishesProvider;
  final CrocodilesProvider crocodilesProvider;

    AnimalsProvider({
    required this.catsProvider,
    required this.dogsProviders,
    required this.fishesProvider,
    required this.crocodilesProvider,
  }) {
    //cargo datos al inicializar
    loadAllAnimals();
  }

  //metodo cargar todos los datos
  Future<void> loadAllAnimals() async {
    try {
      await Future.wait([
        catsProvider.loadCats(),
        dogsProviders.loadDogs(),
        fishesProvider.loadFishes(),
        crocodilesProvider.loadCrocodiles(),
      ]);
      notifyListeners();
    } catch (e) {
      print('Error cargando animales: $e');
    }
  }

  //metodo de búsqueda mejorado
  List<dynamic> buscarPorNombre(String query) {
    if (query.isEmpty) return [];
    
    final searchLower = query.toLowerCase();
    List<dynamic> results = [];
    
    //busco en gatos
    if (catsProvider.listCats.isNotEmpty) {
      results.addAll(catsProvider.listCats.where(
        (cat) => cat.nombre.toLowerCase().contains(searchLower)
      ));
    }
    
    //busco en perros
    if (dogsProviders.listDogs.isNotEmpty) {
      results.addAll(dogsProviders.listDogs.where(
        (dog) => dog.nombre.toLowerCase().contains(searchLower)
      ));
    }
    
    //busco en peces
    if (fishesProvider.listFishes.isNotEmpty) {
      results.addAll(fishesProvider.listFishes.where(
        (fish) => fish.nombre.toLowerCase().contains(searchLower)
      ));
    }
    
    //busco en cocodrilos
    if (crocodilesProvider.listCrocodiles.isNotEmpty) {
      results.addAll(crocodilesProvider.listCrocodiles.where(
        (croc) => croc.name.toLowerCase().contains(searchLower)
      ));
    }

    return results;
  }

  List<Category> get allAnimals {
    return [
      Category(
        title: 'Gatos',
        imagePath: 'assets/images/gatos_listado',
        color: Colors.orange,// color representartivo
      ),
      ...catsProvider.listCats.map((cat) => Category(
        title: cat.nombre,
        imagePath: 'assets/images/gatos_listado',
        color: Colors.orange, // Color para los gatos
      )),
      Category(
        title: 'Perros',
        imagePath: 'assets/images/animals_screen/dog.png',
        color: Colors.brown,
      ),
      ...dogsProviders.listDogs.map((dog) => Category(
        title: dog.nombre,
        imagePath: 'assets/images/animals_screen/dog.png',
        color: Colors.brown, // Color para los perros
      )),
      Category(
        title: 'Peces',
        imagePath: 'assets/images/avatars_peces',
        color: Colors.blue,
      ),
      ...fishesProvider.listFishes.map((fish) => Category(
        title: fish.nombre,
        imagePath: fish.avatar,
        color: Colors.blue, // Color para los peces
      )),
      Category(
        title: 'Cocodrilos',
        imagePath: 'assets/images/animals_screen/cocodrile.png',
        color: Colors.green,
      ),
      ...crocodilesProvider.listCrocodiles.map((crocodile) => Category(
        title: crocodile.name,
        imagePath: crocodile.avatar,
        color: Colors.green, // Color para los cocodrilos
      )),
    ];
  } 
}
