import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/screens/home_screen.dart';
import 'package:appanimals/screens/peces/peces_list_screen.dart';
import 'package:appanimals/widgets/custom_outlined_button.dart';

class AnimalHistory extends StatelessWidget {
  final String title;
  final String text;

  const AnimalHistory({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Historia del Animal')
        ),
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
                SizedBox(height: 50),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 48, 46, 46),
                    wordSpacing: 4,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                // Texto adicional sobre el animal
                SizedBox(height: 60),
                Text(
                  text,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color.fromARGB(255, 32, 32, 32),
                    wordSpacing: 4,
                    height: 1.5,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PecesListScreen()),
                        );
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
