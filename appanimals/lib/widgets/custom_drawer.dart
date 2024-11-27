import 'package:appanimals/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/screens/acerca_de_.dart';
import 'package:appanimals/screens/animals_screen.dart';
import 'package:appanimals/screens/explorar_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:appanimals/providers/theme_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final isLightTheme = themeProvider.currentTheme == ThemeData.light();

    // Establecemos el color de los iconos según el tema
    // final iconColor = isLightTheme ? Colors.white : Colors.black;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 21, 100, 21),
            ),
            child: Center(
                child: Text(
              'A n i m a l s \n   M e n u',
              style: TextStyle(fontSize: 30, color: Colors.white),
            )),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Color.fromARGB(255, 21, 100, 21)),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.pets, color: Color.fromARGB(255, 21, 100, 21)),
            title: const Text('Animales'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AnimalScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.newspaper_sharp,
                color: Color.fromARGB(255, 21, 100, 21)),
            title: const Text('Noticias'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewsScreen()));
            },
          ),
          ListTile(
            leading:
                Icon(Icons.explore, color: Color.fromARGB(255, 21, 100, 21)),
            title: const Text('Explorar'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ExplorarScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Color.fromARGB(255, 21, 100, 21)),
            title: const Text('Acerca de'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AcercaDePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
