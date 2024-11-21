import 'package:flutter/material.dart'; // Importa el paquete de widgets de Flutter.
import 'package:appanimals/screens/home_screen.dart';
import 'package:provider/provider.dart'; // Proveedor de estado
import 'package:appanimals/provider/theme_provider.dart';
import 'package:appanimals/helpers/preferences.dart';
import 'package:appanimals/screens/profile_screen.dart';
import 'package:appanimals/screens/animals_screen.dart';
import 'package:appanimals/provider/fishes_provider.dart';
import 'package:appanimals/screens/peces/list_fishes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initShared();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(isLightMode: Preferences.lightmode),
        ),
        ChangeNotifierProvider<FishesProvider>(
          create: (_) => FishesProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// StatelessWidget: página estática. StatefullWidget: dinámica.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Provider.of<ThemeProvider>(context, listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      initialRoute: '/home',
      title: 'App Animals',
      theme: tema.temaActual,
      routes: {
        '/home': (context) => const HomeScreen(),
        '/profiles': (context) => ProfilesScreen(),
        '/animals': (context) => const AnimalScreen(),
        '/list_fishes': (context) => const ListFishesScreen(),
      },
    );
  }
}
