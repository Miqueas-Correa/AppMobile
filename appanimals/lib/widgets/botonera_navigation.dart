import 'package:flutter/material.dart';
/* import 'package:appanimals/screens/home_screen.dart'; */

class BotoneraNavigation extends StatefulWidget {
  const BotoneraNavigation({super.key});

  @override
  _BotoneraNavigationState createState() => _BotoneraNavigationState();
}

class _BotoneraNavigationState extends State<BotoneraNavigation> {
  int _paginaActual = 0;

  // Lista de widgets de las páginas que se mostrarán
/*   final List<Widget> _pages = [
    const HomeScreen(),
    const Center(child: Text("Pagina Buscar")), // ACA VA LA RUTA DEL BUSCAR ---> WANDA
    const Center(child: Text("Pagina Perfiles")), // ACA VA LA RUTA DE PERFILES --> MATIAS
  ]; */

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        currentIndex: _paginaActual,
        elevation: 10,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        onTap: (value) {
          setState(() {
            _paginaActual = value;  // Cambia la página cuando se selecciona un ítem en BottomNavigationBar
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
      );
      /* floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.help,
          color: Colors.white,
        ),
        onPressed: () {
          // Acción que ocurre cuando el FAQ es presionado
          //BOT???
        },
      );
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ); */
  }
}