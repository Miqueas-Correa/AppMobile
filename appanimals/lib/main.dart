import 'package:appanimals/providers/cocodrilos/crocodiles_provider.dart';
import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'package:appanimals/screens/profile_screen.dart';
import 'package:appanimals/screens/buscar_screen.dart';
import 'package:appanimals/screens/drawer_menu/animals_screen.dart';
import 'package:appanimals/screens/cocodriles/crocodiles_list_screen.dart';
import 'package:appanimals/providers/peces/fishes_provider.dart';
import 'package:appanimals/screens/peces/fishes_list_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/loading_provider.dart';
import 'observers/loading_observer.dart';
import 'widgets/loading_overlay.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FishesProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(create: (_) => CrocodilesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      title: 'App Animals',
      theme: themeProvider.currentTheme,
      routes: {
        '/buscar': (context) => BuscarScreen(),
        '/animals': (context) => AnimalScreen(),
        '/perfiles': (context) => ProfilesScreen(),
        '/crocodile_profile': (context) => const CrocodilesListScreen(),
        '/list_fishes': (context) => const FishesListScreen(),
        
      },
      navigatorObservers: [
        LoadingObserver((isLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
            loadingProvider.setLoading(isLoading);
          });
        }),
      ],
      builder: (context, child) {
        return LoadingOverlay(child: child!);
      },
    );
  }
}