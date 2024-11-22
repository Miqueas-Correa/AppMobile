import 'package:flutter/material.dart';

class BotoneraNavigation extends StatefulWidget {
  const BotoneraNavigation({super.key});

  @override
  BotoneraNavigationState createState() => BotoneraNavigationState();
}

class BotoneraNavigationState extends State<BotoneraNavigation> {
  int _paginaActual = 0;

  // Método público para actualizar _paginaActual
  void cambiarPagina(int nuevaPagina) {
    setState(() {
      _paginaActual = nuevaPagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: BottomNavigationBar(
        key: ValueKey<int>(_paginaActual),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        currentIndex: _paginaActual,
        elevation: 10,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        onTap: (value) {
          setState(() {
            _paginaActual = value;
          });

          switch (value) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Buscar: Página no implementada aún')),
              );
              break;
            case 2:
              Navigator.pushNamed(context, '/profiles');
              break;
            default:
              break;
          }
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
    );
  }
}
