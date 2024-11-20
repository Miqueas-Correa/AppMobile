import 'package:flutter/material.dart';
import 'package:appanimals/screens/acerca_de_.dart';

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
              color: Colors.green,
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
              // Navigator.pushNamed(context, '/animals');
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
