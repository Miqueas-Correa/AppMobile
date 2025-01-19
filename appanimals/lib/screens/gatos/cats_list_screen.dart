import 'package:flutter/material.dart';
import 'package:appanimals/models/cats/cats_model.dart';
import 'package:appanimals/service/cats_service.dart';
import 'cats_list_item.dart';

class CatsListScreen extends StatefulWidget {
  const CatsListScreen({super.key});

  @override
  _CatsListScreenState createState() => _CatsListScreenState();
}

class _CatsListScreenState extends State<CatsListScreen> {
  late Future<List<Cat>> _catsFuture;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _catsFuture = CatsService.fetchCats();
  }

<<<<<<< HEAD
  void _updateSearch(String query) {
=======
  Future<void> _loadCats() async {
    try {
      final cats = await CatsService.fetchCats();
      setState(() {
        _allCats = cats;
        _filteredCats = _allCats;
        _isLoading = false;
      });
      print('Gatos cargados: ${_allCats.length}');
    } catch (e) {
      print('Error cargando gatos: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
>>>>>>> origin/dev
    setState(() {
      //logica d bsuqeda
      _catsFuture = CatsService.fetchCats().then((cats) {
        return cats.where((cat) {
          return cat.nombre.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Gatos'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _updateSearch,
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Cat>>(
              future: _catsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final cats = snapshot.data!;
                return ListView.builder(
                  itemCount: cats.length,
                  itemBuilder: (context, index) {
                    return CatsListItem(cat: cats[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
