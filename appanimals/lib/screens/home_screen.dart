import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:appanimals/widgets/custom_drawer.dart';
import 'package:appanimals/widgets/scroll_horizontal.dart';
import 'package:appanimals/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _paginaActual = 0; // Estado para controlar el índice de la pestaña seleccionada

  // Lista de páginas que corresponden a cada pestaña en el BottomNavigationBar
  final List<Widget> _pages = [
    // Página principal con contenido desplazable
    SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/portada.png', // Ruta de tu imagen
              width: double.infinity,
              height: 450, // Ajuste de altura de la imagen
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Bienvenido a la aplicación de animales "Amor Salvaje"💖.\n\nAutores: Miqueas Correa, Wanda Suarez, Matias Hittler, Brenda Yañez.',
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
    const Center(child: Text('Página Buscar')), // Página Buscar
    ProfilesScreen(), // Pantalla de perfiles
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Amor Salvaje',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        iconTheme: const IconThemeData(color: Colors.white), // Ajustes adicionales
      ),
      drawer: const CustomDrawer(),
      body: _pages[_paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        currentIndex: _paginaActual,
        elevation: 10,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        onTap: (value) {
          setState(() {
            _paginaActual = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            activeIcon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
            activeIcon: Icon(Icons.search_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfiles',
            activeIcon: Icon(Icons.person_outline),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.help,
          color: Colors.white,
        ),
        onPressed: () {
          log('Botón de ayuda presionado');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
