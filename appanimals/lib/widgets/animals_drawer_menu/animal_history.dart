import 'package:flutter/material.dart';
import 'package:appanimals/screens/home_screen.dart';
import 'package:appanimals/screens/peces/fishes_list_screen.dart';
import 'package:appanimals/widgets/animals_drawer_menu/custom_outlined_button.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Historia del Animal'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Título del animal
                SizedBox(height: 60),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: /* const Color.fromARGB(255, 48, 46, 46), */const Color.fromARGB(255, 21, 100, 21),
                    wordSpacing: 4,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                // Texto adicional sobre el animal
                SizedBox(height: 50),
                Card(
                  elevation: 10,
                  color: const Color.fromARGB(255, 21, 100, 21),
                  margin: EdgeInsets.all(5),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Text(
                      text,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        wordSpacing: 4,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ),
                ),
                // Botones de acción
                SizedBox(height: 50),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FishesListScreen()),
                          );
                        } else if (selectedAnimal == 'cocodrilos') {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => CrocodilesListScreen()),
                          // );
                        } else if (selectedAnimal == 'perros') {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => PerrosListScreen()),
                          // );
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