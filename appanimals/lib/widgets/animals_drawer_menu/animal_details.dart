import 'package:flutter/material.dart';
import 'package:appanimals/widgets/animals_drawer_menu/animal_history.dart';

class AnimalDetails extends StatelessWidget {
  final String imagePath;
  final String text;
  final String title;
  final Color titleColor;
  final String animalType;

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
    required this.animalType,
  });

  @override
  Widget build(BuildContext context) {
    //responsive
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
            Stack(children: [
              // Imagen que ocupa toda la pantalla
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: screenHeight, //responsive
                width: screenWidth, // responsive
              ),
              // Botón de continuar
              Positioned(
                bottom: screenHeight * 0.1,
                left: screenWidth * 0.25,
                right: screenWidth * 0.25,
                child: SizedBox(
                  width: screenWidth * 0.5,
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
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
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
                      elevation: 10,
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 21, 100, 21),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.08,
                      ),
                    ),
                    child: const Text("Continuar"),
                  ),
                ),
              ),
            ]),
          ],
        ));
  }
}
