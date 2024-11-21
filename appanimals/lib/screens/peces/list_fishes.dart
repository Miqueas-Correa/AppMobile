import 'package:flutter/material.dart';
import 'package:appanimals/provider/fishes_provider.dart';
import 'package:provider/provider.dart';

class ListFishesScreen extends StatelessWidget {
  const ListFishesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listFishes =
        Provider.of<FishesProvider>(context, listen:true).listFishes;

    print('listFishes..... $listFishes');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Peces'),
      ),
      body: ListView.builder(
        itemCount: listFishes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listFishes[index].especie),
            subtitle: Text(
              '${listFishes[index].name} | ${listFishes[index].color} | ${listFishes[index].id}',
            ),
          );
        },
      ),
    );
  }
}