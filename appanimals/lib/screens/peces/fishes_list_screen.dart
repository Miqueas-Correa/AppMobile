import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:appanimals/screens/peces/fishes_profile_screen.dart';
import 'package:appanimals/services/fishes_services.dart';
import 'package:appanimals/models/peces/fishes_model.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:appanimals/widgets/custom_drawer.dart';


class FishesListScreen extends StatefulWidget {
  const FishesListScreen({super.key});

  @override
  State<FishesListScreen> createState() => _FishesListScreenState();
}

class _FishesListScreenState extends State<FishesListScreen> {
  late Future<List<Fishes>> fishesFuture;
  List<Fishes> _auxiliaarFishes = [];
  String _searchQuery = '';
  bool _searchActive = false;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    fishesFuture = FishesService.fetchFishes();

  }


  //actualiza la pagina
  void _updateSearch(String query) {
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _auxiliaarFishes = _auxiliaarFishes;
      } else {
        _auxiliaarFishes = _auxiliaarFishes.where((fishes) {
          return fishes.nombre.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();
      } 
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Listado de Peces'),
            backgroundColor: const Color.fromARGB(255, 21, 100, 21),
            foregroundColor: Colors.white,
          ),
          drawer: CustomDrawer(),
          body: Column(children: [
              searchArea(),
              listItemsArea(),
            ]),
          bottomNavigationBar: BotoneraNavigation(),
        ),
    );
  }
  
  //aca se muestran los resultados de la bsuqueda
  Expanded listItemsArea() {
    return Expanded(
      child: FutureBuilder<List<Fishes>>(
        future: fishesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } 
          
          final fishes = snapshot.data!;
          _auxiliaarFishes = fishes;

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _auxiliaarFishes.length,
            itemBuilder: (context, index) {
              final fishes = _auxiliaarFishes[index];
              return GestureDetector(
                onTap: () {
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
                        offset: Offset(0,6),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(fishes.avatar),
                        radius: 40,
                      ),
                      const SizedBox(width:10),
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
                      //muestra el favorito
                      IconButton(
                        icon: Icon(
                          fishes.favorite ? Icons.favorite : Icons.favorite_border,
                          color: fishes.favorite ? Colors.red : Color.fromARGB(255, 21, 100, 21),
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
    );
  }                        


  // barra de busqueda
  AnimatedSwitcher searchArea() {
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
                      icon: const Icon(Icons.keyboard_arrow_left_outlined)),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _searchActive = !_searchActive;
                      });
                      _focusNode.requestFocus();
                    },
                    icon: const Icon(Icons.search)
                  ),
                ],
              ),
            ),
    );
  }
}
