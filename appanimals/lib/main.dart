import 'package:flutter/material.dart'; // Importa el paquete de widgets de Flutter.
import 'package:appanimals/screens/home_screen.dart';
import 'package:appanimals/screens/animals_screen.dart';
import 'package:appanimals/providers/fishes_provider.dart';
/* import 'package:appanimals/screens/peces/peces_list_screen.dart'; */
import 'package:appanimals/screens/peces/peces_list_item.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FishesProvider(),
      child: const MyApp(),
    ),
  );
}

// StatelessWidget: pagina estatica. StatefullWidget: dinamico.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  HomeScreen(),
      debugShowCheckedModeBanner: false,
      /* initialRoute: '/home', */
      title: 'App Animals',
      routes: {
        /* '/home': (context) => HomeScreen(), */
        // '/buscar': (context) => const OtherScreen(),  // Define otras rutas
        '/perfiles': (context) => PecesListItem(),
        '/animals': (context) => const AnimalScreen(),
        '/list_fishes': (context) => const PecesListItem(),

        //'profile': (context) => const ProfileScreen(),
      },
    );
  }
}