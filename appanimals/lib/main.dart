import 'package:flutter/material.dart';
import 'package:appanimals/providers/peces/fishes_provider.dart';
import 'package:appanimals/screens/peces/fishes_list_screen.dart';
import 'package:appanimals/screens/home_screen.dart';
import 'package:appanimals/screens/buscar_screen.dart';
import 'package:appanimals/screens/drawer_menu/animals_screen.dart';
import 'package:provider/provider.dart';

void main() async {

  runApp(MultiProvider(
    providers: [
      //ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider<FishesProvider>(
        create: (_) => FishesProvider(),
        lazy: false,
      ),
    ],
    child: const MyApp(),
  ));
}

// StatelessWidget: pagina estatica. StatefullWidget: dinamico.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  HomeScreen(),
      debugShowCheckedModeBanner: false,
      title: 'App Animals',
      routes: {
        '/buscar': (context) => BuscarScreen(), 
        //'/perfiles': (context) => FishesListScreen(),
        '/animals': (context) =>  AnimalScreen(),
        '/list_fishes': (context) => FishesListScreen(),
        
      },
    );
  }
}