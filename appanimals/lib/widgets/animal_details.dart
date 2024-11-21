import 'package:appanimals/screens/home_screen.dart';
import 'package:appanimals/screens/peces/list_fishes.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/screens/animals_screen.dart';

class AnimalDetails extends StatelessWidget {
  final String imagePath;
  final String text;
  final String title;
  final Color titleColor;

  final PageController pageController = PageController(
    initialPage: 0,
  );
  
  // ignore: use_super_parameters
  AnimalDetails({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.title,
    required this.titleColor,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        title: const Text('Historia del animal'),
        foregroundColor: Colors.white,
      ),
      body: PageView(
        controller: pageController,
        children: [
          // Página 1: Imagen con el botón
          Stack(
            children: [
              // Imagen que ocupa toda la pantalla
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height, // Ajusta la altura
                width: MediaQuery.of(context).size.width, // Ajusta el ancho
              ),
              // Botón de continuar
              Positioned(
                bottom: 20,
                left: 130,
                right: 130,
                child: TextButton(
                  onPressed: () {
                    // Navegar a la segunda página al presionar "Continuar"
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear,
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 21, 100, 21),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 30,
                    ),
                  ),
                  child: const Text("Continuar"),
                ),
              ),
            ],
          ),
          // Página 2: Texto adicional
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            color: const Color.fromARGB(255, 21, 100, 21),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      wordSpacing: 4,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  // Texto adicional sobre el animal
                  Text(
                    text,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      wordSpacing: 4,
                      height: 1.5,
                    ),
                  ),
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox (
                        width: 150,
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color.fromARGB(255, 21, 100, 21),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                          ),
                          onPressed: () {
                          // Volver al inicio al presionar "Volver al inicio"
                          /* pageController.jumpToPage(0); */
                            Navigator.pop(context);
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => HomeScreen()));
                          },
                          child: const Text('Ir al inicio'),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color.fromARGB(255, 21, 100, 21),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                          ),
                          onPressed: () {
                            // Volver al inicio al presionar "Volver al inicio"
                            /* pageController.jumpToPage(0); */
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ListFishesScreen())); //ACA HAY QUE CAMBIAR POR LA CLASE DEL LISTADO DE CADA UNO
                          },
                          child: const Text('Ver listado'),
                        ),
                      ),
                    ]
                  ),/*Widget*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}