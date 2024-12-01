import 'package:appanimals/screens/cocodrilos/crocodiles_list_screen.dart';
import 'package:appanimals/screens/list/dogs_list_screen.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/screens/home/home_screen.dart';
import 'package:appanimals/screens/peces/fishes_list_screen.dart';
import 'package:appanimals/widgets/animals_drawer_menu/custom_outlined_button.dart';

class AnimalHistory extends StatelessWidget {
  final String title;
  final String text;
  final String selectedAnimal;

  const AnimalHistory({
    super.key,
    required this.title,
    required this.text,
    required this.selectedAnimal,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Historia del Animal'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: (screenWidth * 0.05)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Título del animal
                SizedBox(height: screenHeight * 0.05),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 21, 100, 21),
                    wordSpacing: 2,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.07,
                  ),
                ),
                // Texto adicional sobre el animal
                SizedBox(height: screenHeight * 0.05),
                Card(
                  elevation: 10,
                  color: const Color.fromARGB(255, 21, 100, 21),
                  margin: const EdgeInsets.all(5),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.04,
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Text(
                      text,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Colors.white,
                        wordSpacing: 2,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // Botones de acción
                SizedBox(height: screenHeight * 0.05),
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
                        if (selectedAnimal == 'peces') {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => FishesListScreen()),
                          // );
                        } else if (selectedAnimal == 'cocodrilos') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CrocodilesListScreen()),
                          );
                        } else if (selectedAnimal == 'perros') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DogsListScreen()),
                          );
                        } else if (selectedAnimal == 'gatos') {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => GatosListScreen()),
                          // );
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
      bottomNavigationBar: BotoneraNavigation(),
    );
  }
}
