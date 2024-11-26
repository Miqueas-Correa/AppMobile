import 'package:appanimals/screens/buscar_screen.dart';
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
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      /* initialRoute: '/home', */
      title: 'App Animals',
      routes: {
        // '/home': (context) => HomeScreen(),
        '/buscar': (context) => BuscarScreen(), // Define otras rutas
        '/perfiles': (context) => PecesListItem(), // aca va la ruta de mati
        '/animals': (context) => AnimalScreen(),
        '/list_fishes': (context) => PecesListItem(),
      },
    );
  }
}
