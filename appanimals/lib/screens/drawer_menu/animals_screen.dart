import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:appanimals/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/widgets/animals_drawer_menu/animal_pair.dart';

class AnimalScreen extends StatelessWidget {
  const AnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Animales'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
      ),
      drawer: CustomDrawer(),
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AnimalPair(
              image1: 'assets/images/animals_screen/cat.jpg',
              text1: 'Gatos',
              detailedImage1: 'assets/images/animals_details/gato_detail.jpg',
              image2: 'assets/images/animals_screen/fish.png',
              text2: 'Peces',
              detailedImage2: 'assets/images/animals_details/peces_details.jpg',
            ),
            SizedBox(height: 10),
            AnimalPair(
              image1: 'assets/images/animals_screen/dog.jpg',
              text1: 'Perros',
              detailedImage1: 'assets/images/animals_details/perro_details.jpg',
              image2: 'assets/images/animals_screen/cocodrile.png',
              text2: 'Cocodrilos',
              detailedImage2:
                  'assets/images/animals_details/cocodrilo_detail.jpg',
            ),
            SizedBox(height: 10),
            AnimalPair(
              image1: 'assets/images/animals_screen/penguin.jpg',
              text1: 'Pingüinos',
              detailedImage1: 'assets/images/animals_screen/penguin.jpg',
              image2: 'assets/images/animals_screen/fox.webp',
              text2: 'Zorros',
              detailedImage2: 'assets/images/animals_screen/fox.webp',
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: BotoneraNavigation(),
    );
  }
}
