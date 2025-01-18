import 'package:appanimals/providers/animals_provider.dart';
import 'package:appanimals/providers/dogs/dogs_providers.dart';
import 'package:appanimals/providers/gatos/cats_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'package:appanimals/screens/screens.dart';
import 'package:appanimals/providers/peces/fishes_provider.dart';
import 'package:appanimals/providers/cocodrilos/crocodiles_provider.dart';
import 'providers/loading_provider.dart';
import 'observers/loading_observer.dart';
import 'widgets/loading_overlay.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FishesProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(create: (_) => CrocodilesProvider()),

        ChangeNotifierProvider(
          create: (context) => AnimalsProvider(
            catsProvider: CatsProvider(),
            dogsProviders: DogsProviders(),
            fishesProvider: context.read<FishesProvider>(),
            crocodilesProvider: context.read<CrocodilesProvider>(),
          ),
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
        title: 'Amor Salvaje',
        theme: themeProvider.currentTheme,
        routes: {
          '/buscar': (context) => const BuscarScreen(),
          '/animals': (context) => const AnimalScreen(),
          '/crocodile_profile': (context) => const CrocodilesListScreen(),
          '/list_fishes': (context) => const FishesListScreen(),
          '/perfiles': (context) => ProfilesScreen(),
        },
        navigatorObservers: [
          LoadingObserver((isLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final loadingProvider =
                  Provider.of<LoadingProvider>(context, listen: false);
              loadingProvider.setLoading(isLoading);
            });
          }),
        ],
        builder: (context, child) {
          return LoadingOverlay(child: child!);
        });
  }
}
