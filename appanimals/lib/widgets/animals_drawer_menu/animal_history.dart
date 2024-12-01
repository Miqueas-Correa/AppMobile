import 'package:appanimals/screens/gatos/cats_list_screen.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:appanimals/screens/list/dogs_list_screen.dart';
import 'package:appanimals/screens/peces/fishes_list_screen.dart';
import 'package:appanimals/screens/cocodriles/crocodiles_list_screen.dart';
import 'package:appanimals/widgets/animals_drawer_menu/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/screens/home/home_screen.dart';
import 'package:appanimals/screens/cocodrilos/crocodiles_list_screen.dart';

class AnimalHistory extends StatelessWidget {
  final String title;
  final String text;
  final String selectedAnimal; // Este es el nuevo parámetro

  const AnimalHistory({
    super.key,
    required this.title,
    required this.text,
    required this.selectedAnimal, // Ahora recibe el tipo de animal
  });

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    final backgroundColor = isLightTheme ? Colors.white : Color(0xFF121212);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Historia del Animal'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Título del animal
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    wordSpacing: 4,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                // Texto adicional sobre el animal
                const SizedBox(height: 30),
                Card(
                  elevation: 10,
                  color: const Color.fromARGB(255, 21, 100, 21), shadowColor: const Color(0xFF3D3C3C),
                  margin: const EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: Text(
                      text,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Colors.white,
                        wordSpacing: 4,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                // Botones de acción
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomOutlinedButton(
                      text: 'Ir al inicio',
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                    CustomOutlinedButton(
                      text: 'Ver listado',
                      onPressed: () {
                        // Dependiendo del tipo de animal, navegamos a la lista correspondiente
                        if (selectedAnimal == 'peces') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FishesListScreen()),
                          );
                        } else if (selectedAnimal == 'cocodrilos') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CrocodilesListScreen()),
                          );
                        } else if (selectedAnimal == 'perros') {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => PerrosListScreen()),
                          // );
                        } else if (selectedAnimal == 'gatos') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CatsListScreen()),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
