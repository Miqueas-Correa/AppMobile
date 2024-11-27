import 'package:appanimals/screens/drawer_menu/animals_screen.dart';
import 'package:appanimals/screens/drawer_menu/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/screens/drawer_menu/acerca_de_.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.pets),
            title: const Text('Animales'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AnimalScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.newspaper_sharp),
            title: const Text('Noticias'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
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
