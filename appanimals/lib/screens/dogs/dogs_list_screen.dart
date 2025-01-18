import 'package:appanimals/models/dogs_model.dart';
import 'package:appanimals/screens/dogs/dogs_detalis_screen.dart';
import 'package:appanimals/service/dogs_service.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DogsListScreen extends StatefulWidget {
  const DogsListScreen({super.key});

  @override
  _dongsListScreenState createState() => _dongsListScreenState();
}

// ignore: camel_case_types
class _dongsListScreenState extends State<DogsListScreen> {
  late Future<List<DogsModel>> _dogsFuture;
  List<DogsModel> _auxiliarDogs = [];
  String _searchQuery = '';
  bool _searchActive = false;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _dogsFuture = DogsService.fetchDogs();
  }

  Future<List<DogsModel>> _fetchDogsWithFavorites() async {
    final dogs = await DogsService.fetchDogs();
    final prefs = await SharedPreferences.getInstance();

    for (var dog in dogs) {
      dog.favorite = prefs.getBool(dog.id) ?? false;
    }

    return dogs;
  }

  void _updateSearch(String? query) {
    setState(() {
      _searchQuery = query ?? '';
      if (_searchQuery.isEmpty) {
        _dogsFuture = _fetchDogsWithFavorites();
      } else {
        _dogsFuture = _fetchDogsWithFavorites().then((dogs) {
          return dogs.where((dog) {
            final searchLower = _searchQuery.toLowerCase();

            final matchesNombre =
                dog.nombre.toLowerCase().contains(searchLower);
            final matchesRaza = dog.raza.toLowerCase().contains(searchLower);
            final matchesFechaNacimiento =
                dog.fechaNacimiento.toLowerCase().contains(searchLower);
            final matchesId = dog.id.toString() == _searchQuery;

            return matchesNombre ||
                matchesRaza ||
                matchesFechaNacimiento ||
                matchesId;
          }).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Listado de perros'),
          backgroundColor: const Color.fromARGB(255, 21, 100, 21),
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            _searchArea(),
            Expanded(
              child: FutureBuilder<List<DogsModel>>(
                future: _dogsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final dogs = snapshot.data!;
                  _auxiliarDogs = dogs;

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _auxiliarDogs.length,
                    itemBuilder: (context, index) {
                      final dog = _auxiliarDogs[index];
                      return GestureDetector(
                        onTap: () async {
                          // Navegar a la pantalla de detalles, pasando el objeto completo
                          final updatedDog = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DogsDetailScreen(dog: dog),
                            ),
                          );

                          if (updatedDog != null) {
                            setState(() {
                              final dogIndex = _auxiliarDogs
                                  .indexWhere((d) => d.id == updatedDog.id);
                              if (dogIndex != -1) {
                                _auxiliarDogs[dogIndex] = updatedDog;
                              }
                            });
                          }
                        },
                        child: Container(
                          height: 100,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(31, 206, 219, 246),
                                blurRadius: 0,
                                spreadRadius: 3,
                                offset: Offset(0, 6),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                child: Image.asset(
                                    'assets/images/profiles/dog_profile.jpeg'),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dog.nombre,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('Raza: ${dog.raza}'),
                                  ],
                                ),
                              ),
                              // Opción para marcar como favorito
                              IconButton(
                                icon: Icon(
                                  dog.favorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      dog.favorite ? Colors.red : Colors.grey,
                                ),
                                onPressed: () async {
                                  final perfs =
                                      await SharedPreferences.getInstance();
                                  setState(() {
                                    dog.favorite = !dog.favorite;
                                  });
                                  perfs.setBool(dog.id, dog.favorite);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BotoneraNavigation(),
      ),
    );
  }

  AnimatedSwitcher _searchArea() {
    return AnimatedSwitcher(
      switchInCurve: Curves.bounceIn,
      switchOutCurve: Curves.bounceOut,
      duration: const Duration(milliseconds: 300),
      child: (_searchActive)
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      onChanged: (value) {
                        _updateSearch(value);
                      },
                      onFieldSubmitted: (value) {
                        _updateSearch(value);
                      },
                      decoration: const InputDecoration(hintText: 'Buscar...'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _searchController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                      _updateSearch('');
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _searchActive = false;
                      });
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.keyboard_arrow_left_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _searchActive = !_searchActive;
                      });
                      _focusNode.requestFocus();
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
    );
  }
}
