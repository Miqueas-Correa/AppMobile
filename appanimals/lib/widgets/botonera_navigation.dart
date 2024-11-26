import 'package:appanimals/screens/buscar_screen.dart';
import 'package:appanimals/screens/home_screen.dart';
import 'package:appanimals/screens/profile_screen.dart';
import 'package:appanimals/screens/peces/peces_list_screen.dart';
import 'package:flutter/material.dart';

class BotoneraNavigation extends StatefulWidget {
  const BotoneraNavigation({
    super.key,
  });

  @override
  _BotoneraNavigationState createState() => _BotoneraNavigationState();
}

class _BotoneraNavigationState extends State<BotoneraNavigation> {
  // ignore: prefer_final_fields
  int _paginaActual = 0;

  //Lista de widgets de las páginas que se mostrarán
  final List<Widget> screens = [
    HomeScreen(),
    BuscarScreen(),
    ProfilesScreen(),
    PecesListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 21, 100, 21),
      elevation: 10, //sombra
      unselectedItemColor: Colors.white, //color de los no seleccionados
      selectedItemColor: Colors.white, //color cuando esta seleccionado el icono
      currentIndex: _paginaActual,
      onTap: (value) {
        setState(() {
          _paginaActual = value;
        });
        //logica para cuando se seleccionan otras pantallas
        if (_paginaActual != 1 && _paginaActual != 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (_paginaActual != 0 && _paginaActual != 2) {
          //aca ruta wanda
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuscarScreen()),
          );
        } else if (_paginaActual != 0 && _paginaActual != 1) {
          //aca ruta matias
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilesScreen()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: Colors.white),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.white),
          label: 'Perfiles',
        ),
      ],
    );
  }
}
