import 'package:flutter/material.dart';
import 'package:appanimals/models/peces/fishes_model.dart';
import 'package:appanimals/helpers/peces/fishes_future.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:appanimals/widgets/custom_drawer.dart';

class PecesListScreen extends StatefulWidget {
  const PecesListScreen({super.key});

  @override
  State<PecesListScreen> createState() => _PecesListScreenState();
}

class _PecesListScreenState extends State<PecesListScreen> {
  // String _searchQuery = '';
  // bool _searchActive = false;
  late Future<List<Fishes>?> listaPeces;
  bool isLoading = false;
  int page = 1;

  /* final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); */

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    if (isLoading) return;

    isLoading = true;
    setState(() {});

    listaPeces = futureFishesList(page);
    isLoading = false;
    page++;
    setState(() {});
  }

  /* Future<List<Fishes>?> _searchFishes(String query) async {
    return searchFishes(query); // searchFishes puede devolver null
  } */


  /* @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  } */

  /* void _updateSearch(String query) {
    setState(() {
      _searchQuery = query;
      
    });
  } */

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
              //searchArea(),
              listItemsArea(),
            ]),
          bottomNavigationBar: BotoneraNavigation(),
        ),
    );
  }
  
  //aca se muestran los resultados de la bsuqueda
  Expanded listItemsArea() {
    return Expanded(
      child: FutureBuilder<List<Fishes>?>(
        future: listaPeces,
        builder: (context, AsyncSnapshot<List<Fishes>?> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final fishes = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context, 'fishes_screen',
                      arguments: <String, dynamic> {'id': fishes.id});
                  },
                  onLongPress: () {
                      print('Long press.....');
                    },
                    leading:
                        Text(fishes.id, style: const TextStyle(fontSize: 15)),
                    title: Text(
                      '${fishes.especie} ${fishes.nombre}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(fishes.color),
                );
              },
              separatorBuilder: (context, index) => const Divider(), 
            );            
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const CircularProgressIndicator();
          }
        }
      )
    );
  }

  // barra de busqueda
  // AnimatedSwitcher searchArea() {
  //   return AnimatedSwitcher(
  //     switchInCurve: Curves.bounceIn,
  //     switchOutCurve: Curves.bounceOut,
  //     duration: const Duration(milliseconds: 300),
  //     child: (_searchActive)
  //         ? Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   child: TextFormField(
  //                     controller: _searchController,
  //                     focusNode: _focusNode,
  //                     onChanged: (value) {
  //                       _updateSearch(value);
  //                     },
  //                     onFieldSubmitted: (value) {
  //                       _updateSearch(value);
  //                     },
  //                     decoration: const InputDecoration(hintText: 'Buscar...'),
  //                   ),
  //                 ),
  //                 IconButton(
  //                   onPressed: () {
  //                     _searchController.clear();
  //                     FocusManager.instance.primaryFocus?.unfocus();
  //                     _updateSearch('');
  //                   },
  //                   icon: const Icon(Icons.clear),
  //                 ),
  //                 IconButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       _searchActive = false;
  //                     });
  //                   },
  //                   icon: const Icon(Icons.arrow_back),
  //                 ),
  //               ],
  //             ),
  //           )
  //         : Container(
  //             padding: const EdgeInsets.all(2),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 IconButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     icon: const Icon(Icons.keyboard_arrow_left_outlined)),
  //                 IconButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       _searchActive = !_searchActive;
  //                     });
  //                     _focusNode.requestFocus();
  //                   },
  //                   icon: const Icon(Icons.search)
  //                 ),
  //               ],
  //             ),
  //           ),
  //   );
  // }
}