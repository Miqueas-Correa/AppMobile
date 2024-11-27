import 'package:appanimals/providers/crocodiles_provider.dart';
import 'package:appanimals/screens/animals_screen.dart';
import 'package:appanimals/screens/buscar_screen.dart';
import 'package:appanimals/screens/cocodrilos/crocodiles_list_screen.dart';
import 'package:appanimals/screens/peces/peces_list_item.dart';
import 'package:appanimals/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/loading_provider.dart';
import 'providers/fishes_provider.dart';
import 'observers/loading_observer.dart';
import 'widgets/widgets_matias/loading_overlay.dart';

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
        '/perfiles': (context) => ProfilesScreen(),
        '/animals': (context) => const AnimalScreen(),
        '/list_fishes': (context) => const PecesListItem(),
        '/crocodile_profile': (context) => const CrocodilesListScreen(),
      },
      navigatorObservers: [
        LoadingObserver((isLoading) {
          final loadingProvider =
              Provider.of<LoadingProvider>(context, listen: false);
          loadingProvider.setLoading(isLoading);
        }),
      ],
      builder: (context, child) {
        return LoadingOverlay(child: child!);
      },
    );
  }
}
