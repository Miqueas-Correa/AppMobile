import 'dart:developer';
import 'package:flutter/material.dart';
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
  List<Fishes> _auxiliarFishes = [];
  String _searchQuery = '';
  bool _searchActive = false;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _fishesFuture = FishesService.fetchFishes();
  }

  void _updateSearch(String? query) {
    setState(() {
      _searchQuery = query ?? '';
      if (_searchQuery.isEmpty) {
        _auxiliarFishes = _auxiliarFishes; // Restablecer al estado original
      } else {
        _auxiliarFishes = _auxiliarFishes.where((fishes) {
          return fishes.nombre.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();
      }
    });
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
                  _auxiliarFishes = fishes;

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _auxiliarFishes.length,
                    itemBuilder: (context, index) {
                      final fishes = _auxiliarFishes[index];
                      return GestureDetector(
                        onTap: () {
                          // Navegar a la pantalla de detalles, pasando el objeto completo
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FishesDetailScreen(fishes: fishes),
                            ),
                          );
                        },
                        onLongPress: () {
                          log('onLongPress $index');
                        },
                        child: Container(
                          height: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                backgroundImage: NetworkImage(fishes.avatar),
                                radius: 40,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fishes.nombre,
                                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                    ),
                                    Text('Color: ${fishes.color}'),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  fishes.favorite ? Icons.favorite : Icons.favorite_border,
                                  color: fishes.favorite ? Color.fromARGB(255, 21, 100, 21) : Colors.grey,
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