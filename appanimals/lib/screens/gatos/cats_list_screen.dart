import 'package:appanimals/models/cats/cats_model.dart';
import 'package:appanimals/screens/gatos/cats_details_screen.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/widgets/custom_drawer.dart';
import 'package:appanimals/service/cats_service.dart';

class CatsListScreen extends StatefulWidget {
  const CatsListScreen({super.key});

  @override
  _CatsListScreenState createState() => _CatsListScreenState();
}

class _CatsListScreenState extends State<CatsListScreen> {
  List<Cats> _allCats = [];
  List<Cats> _filteredCats = [];
  bool _isLoading = true;
  String _searchQuery = '';
  bool _searchActive = false;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    print('Iniciando carga de datos');
    _loadCats();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _loadCats() async {
    try {
      final cats = await CatsService.fetchCats();
      setState(() {
        _allCats = cats;
        _filteredCats = cats;
        _isLoading = false;
      });
      print('Gatos cargados: ${cats.length}');
    } catch (e) {
      print('Error cargando gatos: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _filterCats();
    });
  }

  void _filterCats() {
    if (_searchQuery.isEmpty) {
      _filteredCats = _allCats;
    } else {
      _filteredCats = _allCats.where((cats) {
        return cats.nombre.toLowerCase().contains(_searchQuery) ||
            cats.color.toLowerCase().contains(_searchQuery) ||
            cats.raza.toLowerCase().contains(_searchQuery);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Gatos'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          _searchArea(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _allCats.isEmpty
                    ? const Center(child: Text('No hay gatos disponibles, lola'))
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _filteredCats.length,
                        itemBuilder: (context, index) {
                          final cats = _filteredCats[index];
                          String avatarPath = _getAvatarPath(index);

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CatsDetailsScreen(
                                    cat: cats,
                                    avatarPath: avatarPath,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 110,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cats.nombre,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('Raza: ${cats.raza}'),
                                        Text('Color: ${cats.color}'),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      cats.favorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: cats.favorite
                                          ? const Color.fromARGB(255, 21, 100, 21)
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        cats.favorite = !cats.favorite;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      bottomNavigationBar: const BotoneraNavigation(),
    );
  }

  String _getAvatarPath(int index) {
    int avatarIndex = index % 10;
    return 'assets/images/gatos_listado/gato${avatarIndex + 1}${avatarIndex == 9 ? ".png" : ".jpg"}';
  }

  Widget _searchArea() {
    return AnimatedSwitcher(
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
