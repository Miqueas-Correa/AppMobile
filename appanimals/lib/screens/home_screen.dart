import 'package:appanimals/widgets/custom_drawer.dart';
import 'package:appanimals/widgets/scroll_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Amor Salvaje',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        // Hace que el contenido sea desplazable
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/portada.png', // Ruta de tu imagen
                fit: BoxFit.contain, // Ajusta la imagen para que ocupe todo el espacio disponible sin distorsionar
              ),
              const SizedBox(height: 20),
              const Text(
                '🐾 ¡Bienvenido a Amor Salvaje! 🐾.\n'
                'Descubre el fascinante mundo de los animales. Aquí podrás explorar información interesante, aprender sobre tus especies favoritas y disfrutar de herramientas diseñadas especialmente para los amantes de los animales. ¡Gracias por ser parte de nuestra comunidad y ayudar a celebrar la diversidad de la vida en nuestro planeta! 🌎',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40), // Espaciado antes del scroll horizontal
              // Scroll horizontal de tarjetas
              HorizontalScroll(
                imagePaths: List.generate(
                  5,
                  (index) =>
                      'assets/images/scroll_horizontal/animal_${index + 1}.jpg',
                ),
              ),
              const SizedBox(height: 20), // Espaciado al final
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.help,
          color: Colors.white,
        ),
        onPressed: () {
          // Acción del botón flotante (puedes agregar lo que necesites aquí)
        },
      ),
      bottomNavigationBar: const BotoneraNavigation(), // Coloca la BotoneraNavigation correctamente
    );
  }
}
