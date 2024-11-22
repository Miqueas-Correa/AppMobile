import 'package:flutter/material.dart';
import 'package:appanimals/screens/home_screen.dart';
import 'package:appanimals/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:appanimals/provider/theme_provider.dart';
import 'package:appanimals/screens/animals_screen.dart';
import 'package:appanimals/provider/fishes_provider.dart';
import 'package:appanimals/screens/peces/list_fishes.dart';
import 'package:appanimals/screens/news_screen.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:appanimals/helpers/preferences.dart';

void main() async {
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Usa el nombre correcto de la clase BotoneraNavigationState
    final GlobalKey<BotoneraNavigationState> _botoneraKey = GlobalKey<BotoneraNavigationState>();

    final tema = Provider.of<ThemeProvider>(context, listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Animals'),
        ),
        body: const HomeScreen(),
        bottomNavigationBar: BotoneraNavigation(key: _botoneraKey),
      ),
      initialRoute: '/home',
      title: 'App Animals',
      theme: tema.temaActual,
      routes: {
        '/home': (context) => const HomeScreen(),
        '/profiles': (context) => ProfilesScreen(botoneraKey: _botoneraKey),
        '/animals': (context) => const AnimalScreen(),
        '/list_fishes': (context) => const ListFishesScreen(),
        '/noticias': (context) => const NewsScreen(),
      },
    );
  }
}
