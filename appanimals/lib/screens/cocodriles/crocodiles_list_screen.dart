import 'dart:developer';
import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/screens/cocodriles/crocodiles_details_screen.dart';
import 'package:appanimals/service/crocodiles_service.dart';
import 'package:appanimals/models/crocodiles/crocodiles_model.dart';

class CrocodilesListScreen extends StatefulWidget {
  const CrocodilesListScreen({super.key});

  @override
  _CrocodilesListScreenState createState() => _CrocodilesListScreenState();
}

class _CrocodilesListScreenState extends State<CrocodilesListScreen> {
  late Future<List<Crocodile>> _crocodilesFuture;
  List<Crocodile> _auxiliarCrocodiles = [];
  String _searchQuery = '';
  bool _searchActive = false;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _crocodilesFuture = CrocodilesService.fetchCrocodiles();
  }

  void _updateSearch(String? query) {
    setState(() {
      _searchQuery = query ?? '';
      if (_searchQuery.isEmpty) {
        _crocodilesFuture = CrocodilesService.fetchCrocodiles();
      } else {
        _crocodilesFuture =
            CrocodilesService.fetchCrocodiles().then((crocodiles) {
          return crocodiles.where((crocodile) {
            final searchLower = _searchQuery.toLowerCase();

            // Buscar por nombre, color o hábitat (coincidencia parcial)
            final matchesName =
                crocodile.name.toLowerCase().contains(searchLower);
            final matchesColor =
                crocodile.color.toLowerCase().contains(searchLower);
            final matchesHabitat =
                crocodile.habitat.toLowerCase().contains(searchLower);

            // Buscar por id (coincidencia exacta)
            final matchesId = crocodile.id.toString() == _searchQuery;

            return matchesName || matchesColor || matchesHabitat || matchesId;
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
          title: const Text('Listado de Cocodrilos'),
          backgroundColor: const Color.fromARGB(255, 21, 100, 21),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _searchArea(),
            Expanded(
              child: FutureBuilder<List<Crocodile>>(
                future: _crocodilesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final crocodiles = snapshot.data!;
                  _auxiliarCrocodiles = crocodiles;

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _auxiliarCrocodiles.length,
                    itemBuilder: (context, index) {
                      final crocodile = _auxiliarCrocodiles[index];
                      return GestureDetector(
                        onTap: () {
                          // Navegar a la pantalla de detalles, pasando el objeto completo
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CrocodilesDetailScreen(crocodile: crocodile),
                            ),
                          );
                        },
                        onLongPress: () {
                          log('onLongPress $index');
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
                                backgroundImage: NetworkImage(crocodile.avatar),
                                radius: 40,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      crocodile.name,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('Color: ${crocodile.color}'),
                                  ],
                                ),
                              ),
                              // Opción para marcar como favorito
                              IconButton(
                                icon: Icon(
                                  crocodile.favorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: crocodile.favorite
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    crocodile.favorite = !crocodile.favorite;
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
        bottomNavigationBar: BotoneraNavigation(),
      ),
    );
  }

  AnimatedSwitcher _searchArea() {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
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
                      decoration: const InputDecoration(
                          hintText: 'Buscar por nombre/habitat/color/id...'),
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