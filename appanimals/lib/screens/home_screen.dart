import 'package:flutter/material.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Hace que el contenido sea desplazable
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/portada.png',
                width: double.infinity, 
                height: 400,
                fit: BoxFit.cover, 
              ),
              const SizedBox(height: 20),
              const Text(
                'Bienvenido a la aplicación de animales "Amor Salvaje"💖.\nAutores: Miqueas Correa, Wanda Suarez, Matias Hittler, Brenda Yañez.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              //Scroll horizontal

              // boton
            ],
          ),
        ),
      ),
      bottomNavigationBar: BotoneraNavigation(),
    );
  }
}