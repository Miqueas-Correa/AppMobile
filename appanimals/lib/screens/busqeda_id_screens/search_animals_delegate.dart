import 'package:appanimals/providers/animals_provider.dart';
import 'package:appanimals/screens/cocodriles/crocodiles_details_screen.dart' as cocodriles;
import 'package:appanimals/screens/dogs/dogs_detalis_screen.dart';
import 'package:appanimals/screens/gatos/cats_details_screen.dart' as cats;
import 'package:appanimals/screens/peces/fishes_details_screen.dart';
import 'package:flutter/material.dart';


class SearchAnimalsDelegate extends SearchDelegate<String> {
  final AnimalsProvider animalsProvider;

  SearchAnimalsDelegate(this.animalsProvider);

  @override
  String get searchFieldLabel => 'Buscar animal por nombre';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return const SizedBox();

    final results = _searchInAllAnimals();
    
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final animal = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(_getAnimalImage(animal)),
          ),
          title: Text(_getAnimalName(animal)),
          subtitle: Text(_getAnimalType(animal)),
          trailing: _getAnimalIcon(animal),
          onTap: () => _navigateToDetail(context, animal),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Ingresa el nombre del animal que buscas'),
      );
    }
    return buildResults(context);
  }

  List<dynamic> _searchInAllAnimals() {
    List<dynamic> results = [];
    
    // Buscar en gatos
    results.addAll(animalsProvider.catsProvider.listCats.where(
      (cat) => cat.nombre.toLowerCase().contains(query.toLowerCase())
    ));
    
    // Buscar en perros
    results.addAll(animalsProvider.dogsProviders.listDogs.where(
      (dog) => dog.nombre.toLowerCase().contains(query.toLowerCase())
    ));
    
    // Buscar en peces
    results.addAll(animalsProvider.fishesProvider.listFishes.where(
      (fish) => fish.nombre.toLowerCase().contains(query.toLowerCase())
    ));
    
    // Buscar en cocodrilos
    results.addAll(animalsProvider.crocodilesProvider.listCrocodiles.where(
      (croc) => croc.name.toLowerCase().contains(query.toLowerCase())
    ));
    
    return results;
  }

  String _getAnimalType(dynamic animal) {
    if (animal.runtimeType.toString().contains('Cats')) return 'Gato';
    if (animal.runtimeType.toString().contains('Dogs')) return 'Perro';
    if (animal.runtimeType.toString().contains('Fishes')) return 'Pez';
    if (animal.runtimeType.toString().contains('Crocodile')) return 'Cocodrilo';
    return 'Animal';
  }

  String _getAnimalName(dynamic animal) {
    if(animal.runtimeType.toString().contains('Crocodile')){
      return animal.name;
    }
    return animal.nombre;
  }

  String _getAnimalImage(dynamic animal) {
    switch (_getAnimalType(animal)) {
      case 'Gato':
        return 'assets/images/buscar_page/gato_2.jpg';
      case 'Perro':
        return 'assets/images/animals_screen/dog.png';
      case 'Pez':
        return 'assets/images/buscar_page/pez_2.jpg';
      case 'Cocodrilo':
        return 'assets/images/animals_screen/cocodrile.png';
      default:
        return 'assets/images/default_animal.png';
    }
  }

  Icon _getAnimalIcon(dynamic animal) {
    switch (_getAnimalType(animal)) {
      case 'Gato':
        return const Icon(Icons.pets, color: Colors.orange);
      case 'Perro':
        return const Icon(Icons.pets, color: Colors.brown);
      case 'Pez':
        return const Icon(Icons.water, color: Colors.blue);
      case 'Cocodrilo':
        return const Icon(Icons.forest, color: Colors.green);
      default:
        return const Icon(Icons.question_mark);
    }
  }

  void _navigateToDetail(BuildContext context, dynamic animal) {
    final type = _getAnimalType(animal);
    Widget screen;
    
    switch (type) {
      case 'Gato':
        screen = cats.CatsDetailsScreen(
          cat: animal,
          avatarPath: _getAnimalImage(animal),
        );
        break;
      case 'Perro':
        screen = DogsDetailScreen(dog: animal);
        break;
      case 'Pez':
        screen = FishesDetailScreen(
          fishes: animal,
          avatarPath: _getAnimalImage(animal),
        );
        break;
      case 'Cocodrilo':
        screen = cocodriles.CrocodilesDetailScreen(crocodile: animal);
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}