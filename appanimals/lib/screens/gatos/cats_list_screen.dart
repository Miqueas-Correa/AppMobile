import 'package:appanimals/screens/gatos/cats_list_item.dart';
import 'package:appanimals/service/cats_service.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/screens/gatos/cats_details_screen.dart';
import 'package:appanimals/models/cats_model.dart';

class CatsListScreen extends StatefulWidget {
  const CatsListScreen({super.key});

  @override
  _CatsListScreenState createState() => _CatsListScreenState();
}

class _CatsListScreenState extends State<CatsListScreen> {
  late Future<List<CatsModel>> _catsFuture;
  List<CatsModel> _filteredCats = [];
  String _searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _catsFuture = CatsService.fetchCats();
  }

  void _updateSearch(String query){
    setState(() {
      _searchQuery = query;
      _filteredCats = _filteredCats.where((cat){
        return cat.nombre!.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Gatos'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: FutureBuilder<List<CatsModel>>(
              future: _catsFuture,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError){
                  return Center(child: Text('Errorr: ${snapshot.error}'));
                }
                final cats = snapshot.data ?? [];
                _filteredCats = cats;

                return ListView.builder(
                  itemCount: _filteredCats.length,
                  itemBuilder: (context, index) {
                    final cat = _filteredCats[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                              CatsDetailsScreen(cat:cat),
                          ),
                        );
                      },
                      child: CatsListItem(cat:cat),
                    );
                  }
                );
              }
            )
          )
        ],
      )
    );
  }
  Widget _buildSearchBar(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        onChanged: _updateSearch,
        decoration: const InputDecoration(
          labelText: 'Buscar gato....',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}