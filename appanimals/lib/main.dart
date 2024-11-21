import 'package:appanimals/screens/news_screen.dart';
import 'package:flutter/material.dart'; // Importa el paquete de widgets de Flutter.
import 'package:appanimals/screens/home_screen.dart';
import 'package:appanimals/screens/animals_screen.dart';
import 'package:appanimals/providers/fishes_provider.dart';
import 'package:appanimals/screens/peces/list_fishes.dart';
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
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      title: 'App Animals',
      routes: {
        // '/buscar': (context) => const OtherScreen(),  // Define otras rutas
        // '/perfiles': (context) => const OtherScreen(),
        '/animals': (context) => const AnimalScreen(),
        '/list_fishes': (context) => const ListFishesScreen(),
        '/noticias': (context) => const NewsScreen(),
      },
    );
  }
}
