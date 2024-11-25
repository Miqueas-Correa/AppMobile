import 'dart:developer';
import 'package:appanimals/screens/peces/peces_list_item.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:appanimals/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/mocks/fishes_mock.dart' show elements;

class PecesListScreen extends StatefulWidget {
  const PecesListScreen({super.key});

  @override
  State<PecesListScreen> createState() => _PecesListScreenState();
}

class _PecesListScreenState extends State<PecesListScreen> {
  List _auxiliarElements = [];
  String _searchQuery = '';
  bool _searchActive = false;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _auxiliarElements = elements;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateSearch(String? query) {
    setState(() {
      _searchQuery = query ?? '';
      if (_searchQuery.isEmpty) {
        _auxiliarElements = elements; // Restablecer al estado original
      } else {
        _auxiliarElements = elements.where((element) {
          return element[1].toLowerCase().contains(_searchQuery.toLowerCase());
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
  
  Expanded listItemsArea() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 54,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => PecesListItem(),
                  settings: RouteSettings(
                    arguments: <String, dynamic>{
                      'avatar': elements[index][0],
                      'name': elements[index][1],
                      'especie': elements[index][2],
                      'color': elements[index][3],
                      'stars': elements[index][4],
                      'favorite': elements[index][5],}
                  ),
                )
              );
              FocusManager.instance.primaryFocus?.unfocus();
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
                    color: Color.fromARGB(54, 187, 189, 196),
                    blurRadius: 0,
                    spreadRadius: 1,
                    offset: Offset(0, 0))
                  ],
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 1,
                )
              ),
              child: Row(
                children: [
                  Image.asset(
                      'assets/avatars_peces/${_auxiliarElements[index][0]}.png',
                      width: 50,
                      height: 50),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _auxiliarElements[index][1],
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(_auxiliarElements[index][2]),
                      ],
                    ),
                  ),
                  Icon(_auxiliarElements[index][4] > 3
                      ? Icons.star
                      : Icons.star_border_outlined),
                  Text(_auxiliarElements[index][4].toString())
                ],
              ),
            ),
          );
        },
      ),
    );
  }

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
                      icon: const Icon(Icons.search)),
                ],
              ),
            ),
    );
  }
}