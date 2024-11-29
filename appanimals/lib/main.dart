import 'package:appanimals/providers/crocodiles_provider.dart';
import 'package:appanimals/screens/cocodrilos/crocodiles_list_screen.dart';
import 'package:appanimals/screens/profile_screen.dart';
/* import 'package:appanimals/screens/peces/fishes_screen.dart'; */
import 'package:flutter/material.dart'; // Importa el paquete de widgets de Flutter.
import 'package:appanimals/screens/busqeda_id_screens/buscar_screen.dart';
import 'package:appanimals/screens/animals_screen.dart';
import 'package:appanimals/providers/peces/fishes_provider.dart';
/* import 'package:appanimals/screens/peces/peces_list_item.dart'; */
import 'package:appanimals/models/peces/listview_separated_fishes.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'screens/home/home_screen.dart';
import 'providers/theme_provider.dart';
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
      title: 'Animals',
      theme: themeProvider.currentTheme,
      routes: {
        '/buscar': (context) => BuscarScreen(),
        '/animals': (context) => const AnimalScreen(),
        '/crocodile_profile': (context) => const CrocodilesListScreen(),
        '/list_fishes': (context) => const ListViewSeparatedScreen(),
        '/perfiles': (context) => ProfilesScreen(),
      },
      navigatorObservers: [
        // MODIFIQUE SOLO ESTO, PARA Q ME CORRA EN MI CELUU :)))
        LoadingObserver((isLoading) {
          SchedulerBinding.instance.addPostFrameCallback((_) { //registro um callback q se ejecuta dps d q el arbol de los widgets haya sido construido y renderizado en ese frame, el '_' es una marca de tiempo del frame
            final loadingProvider = 
                Provider.of<LoadingProvider>(context, listen: false); //obtengo la instancia de loandingprovider sin escuchar cambios futuros
            loadingProvider.setLoading(isLoading);//actulizo el estado de carga con el valor actual de isloanding y avisa a tds los widgets q depende de loandindprovider
          });
        }),
      ], // HASTA ACA MODIFIQUEEE
      builder: (context, child) {
        return LoadingOverlay(child: child!);
      },
    );
  }
}
