import 'dart:developer';
import 'package:appanimals/widgets/scroll_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/widgets/custom_drawer.dart';

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
        backgroundColor: Colors.green,
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
                width: double
                    .infinity, // El ancho de la imagen ocupa todo el ancho de la pantalla
                height:
                    450, // Altura de la imagen, ajusta según tus necesidades
                fit: BoxFit
                    .cover, // Ajusta la imagen para que ocupe todo el espacio disponible sin distorsionar
              ),
              const SizedBox(
                  height: 20), // Espaciado entre la imagen y el texto
              const Text(
                'Bienvenido a la aplicación de animales "Amor Salvaje"💖.\n\nAutores: Miqueas Correa, Wanda Suarez, Matias Hittler, Brenda Yañez.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                  height: 40), // Espaciado antes del scroll horizontal
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
          log('Clicked');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
