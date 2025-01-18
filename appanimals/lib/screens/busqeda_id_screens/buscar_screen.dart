import 'package:appanimals/screens/busqeda_id_screens/search_animals_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appanimals/providers/animals_provider.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';

class BuscarScreen extends StatelessWidget {
  const BuscarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final animalsProvider = Provider.of<AnimalsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        centerTitle: true,
        title: const Text(
          'Buscar animal',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchAnimalsDelegate(animalsProvider),
                );
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/animals_friends.jpg',
              height: 450,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Bienvenido a la pantalla de Bucar Animales!',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 21, 100, 21)),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BotoneraNavigation(),
    );
  }
}
