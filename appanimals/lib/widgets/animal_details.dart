import 'package:appanimals/widgets/animal_history.dart';
import 'package:flutter/material.dart';

class AnimalDetails extends StatelessWidget {
  final String imagePath;
  final String text;
  final String title;
  final Color titleColor;
  final String animalType; // Nueva propiedad para identificar el tipo de animal

  final PageController pageController = PageController(
    initialPage: 0,
  );

  // Constructor
  AnimalDetails({
    super.key,
    required this.imagePath,
    required this.text,
    required this.title,
    required this.titleColor,
    required this.animalType, // Recibimos el tipo de animal (por ejemplo: 'perros', 'gatos', 'peces', 'cocodrilos')
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Historia del animal'),
          backgroundColor: const Color.fromARGB(255, 21, 100, 21),
          foregroundColor: Colors.white,
        ),
        body: PageView(
          controller: pageController,
          children: [
            Stack(
              children: [
                // Imagen que ocupa toda la pantalla
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height:
                      MediaQuery.of(context).size.height, // Ajusta la altura
                  width: MediaQuery.of(context).size.width, // Ajusta el ancho
                ),
                // Botón de continuar
                Positioned(
                  bottom: 20,
                  left: 130,
                  right: 130,
                  child: TextButton(
                    onPressed: () {
                      // Animación personalizada para navegar a AnimalHistory
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  AnimalHistory(
                            title: title,
                            text: text,
                            selectedAnimal:
                                animalType, // Pasamos el tipo de animal
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin =
                                Offset(1.0, 0.0); // Comienza desde la derecha
                            const end = Offset.zero; // Termina en el centro
                            const curve = Curves.linear;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
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
            )
          ],
        ));
  }
}
