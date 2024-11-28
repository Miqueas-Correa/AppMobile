import 'package:appanimals/providers/theme_provider.dart';
import 'package:appanimals/screens/drawer_menu/acerca_de_.dart';
import 'package:appanimals/screens/drawer_menu/animals_screen.dart';
import 'package:appanimals/screens/drawer_menu/news_screen.dart';
import 'package:appanimals/screens/explorar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    //final isLightTheme = themeProvider.currentTheme == ThemeData.light();

    return Drawer(     
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              final isLightTheme = themeProvider.currentTheme == ThemeData.light();

              return Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                color: Color.fromARGB(255, 21, 100, 21),
                child: ListTile(
                  leading: Icon(
                    isLightTheme ? Icons.wb_sunny : Icons.nightlight_round,
                    color: isLightTheme ? Colors.white : Colors.white,
                  ),
                  title: Text(
                    isLightTheme ? 'Modo Claro' : 'Modo Oscuro',
                    style: TextStyle(color: isLightTheme ? Colors.white : Colors.white),
                  ),
                  onTap: () {
                    // Cambiar entre modo claro u oscuro
                    themeProvider.toggleTheme();
                  },
                ),
              );
            }
          ),
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 21, 100, 21),
            ),
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                'A n i m a l s \n   M e n u',
                style: TextStyle(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
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
                MaterialPageRoute(builder: (context) => const AnimalScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.newspaper_sharp, color: Color.fromARGB(255, 21, 100, 21)),
            title: const Text('Noticias'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.explore, color: Color.fromARGB(255, 21, 100, 21)),
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
