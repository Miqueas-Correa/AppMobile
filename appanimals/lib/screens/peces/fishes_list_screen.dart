import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:appanimals/widgets/custom_drawer.dart';
import 'package:appanimals/screens/peces/fishes_details_screen.dart';
import 'package:appanimals/services/peces/fishes_service.dart';
import 'package:appanimals/models/peces/fishes_model.dart';

class FishesListScreen extends StatefulWidget {
  const FishesListScreen({super.key});

  @override
  _FishesListScreenState createState() => _FishesListScreenState();
}

class _FishesListScreenState extends State<FishesListScreen> {
  late Future<List<Fishes>> _fishesFuture;
  List<Fishes> _allFishes = [];
  List<Fishes> _filteredFishes = [];

  String _searchQuery = '';
  bool _searchActive = false;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _fishesFuture = FishesService.fetchFishes();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _filterFishes();
    });
  }

  void _filterFishes() {
    if (_searchQuery.isEmpty) {
      _filteredFishes = _allFishes;
    } else {
      _filteredFishes = _allFishes.where((fishes) {
        return fishes.nombre.toLowerCase().contains(_searchQuery) ||
            fishes.color.toLowerCase().contains(_searchQuery) ||
            fishes.especie.toLowerCase().contains(_searchQuery) ||
            fishes.id.toString().contains(_searchQuery);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Listado de Peces'),
          backgroundColor: const Color.fromARGB(255, 21, 100, 21),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            _searchArea(),
            Expanded(
              child: FutureBuilder<List<Fishes>>(
                future: _fishesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final fishes = snapshot.data!;
                  _allFishes = fishes; //guarda datos originales
                  _filterFishes(); //filtra

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _filteredFishes.length,
                    itemBuilder: (context, index) {
                      final fishes = _filteredFishes[index];

                      //avatar
                      String avatarPath = _getAvatarPath(index);

                      return GestureDetector(
                        onTap: () {
                          // Navegar a la pantalla de detalles, pasando el objeto completo
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FishesDetailScreen(
                                  fishes: fishes, avatarPath: avatarPath),
                            ),
                          );
                        },
                        onLongPress: () {
                          log('onLongPress $index');
                        },
                        child: Container(
                          height: 110,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 229, 235, 231),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Color.fromARGB(31, 83, 85, 84),
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(31, 78, 80, 79),
                                blurRadius: 3,
                                spreadRadius: 0,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(avatarPath),
                                radius: 30,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fishes.nombre,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('Especie: ${fishes.especie}'),
                                    Text('Color: ${fishes.color}'),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  fishes.favorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: fishes.favorite
                                      ? Color.fromARGB(255, 21, 100, 21)
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    fishes.favorite = !fishes.favorite;
                                  });
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
      ),
    );
  }

  //metodo para obtener la ruta de los avatars
  String _getAvatarPath(int index) {
    int avatarIndex = index % 10;

    switch (avatarIndex) {
      case 0:
        return 'assets/images/avatars_peces/avatar1.png';
      case 1:
        return 'assets/images/avatars_peces/avatar2.png';
      case 2:
        return 'assets/images/avatars_peces/avatar3.png';
      case 3:
        return 'assets/images/avatars_peces/avatar4.png';
      case 4:
        return 'assets/images/avatars_peces/avatar5.png';
      case 5:
        return 'assets/images/avatars_peces/avatar6.png';
      case 6:
        return 'assets/images/avatars_peces/avatar7.png';
      case 7:
        return 'assets/images/avatars_peces/avatar8.png';
      case 8:
        return 'assets/images/avatars_peces/avatar9.png';
      case 9:
        return 'assets/images/avatars_peces/avatar10.png';
      default:
        return 'assets/images/avatars_peces/avatar1.png';
    }
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
                        _onSearchChanged();
                      },
                      // onFieldSubmitted: (value) {
                      //   _updateSearch(value);
                      // },
                      decoration: const InputDecoration(hintText: 'Buscar...'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _searchController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                      _onSearchChanged();
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
