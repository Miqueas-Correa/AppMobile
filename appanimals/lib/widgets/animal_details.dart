import 'package:appanimals/widgets/animal_history.dart';
import 'package:flutter/material.dart';

class AnimalDetails extends StatelessWidget {
  final String imagePath;
  final String text;
  final String title;
  final Color titleColor;

  // Constructor
  const AnimalDetails({
    super.key,
    required this.imagePath,
    required this.text,
    required this.title,
    required this.titleColor,
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
      body: Stack(
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
                // Navegar a la pantalla AnimalHistory al presionar "Continuar"
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimalHistory(
                    title: title,
                    text: text,
                  )),
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
    );
  }
}