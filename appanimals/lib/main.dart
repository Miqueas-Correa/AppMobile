/* import 'package:appanimals/screens/peces/fishes_screen.dart'; */
import 'package:flutter/material.dart'; // Importa el paquete de widgets de Flutter.
import 'package:appanimals/screens/home_screen.dart';
import 'package:appanimals/screens/buscar_screen.dart';
import 'package:appanimals/screens/animals_screen.dart';
import 'package:appanimals/providers/peces/fishes_provider.dart';
/* import 'package:appanimals/screens/peces/peces_list_item.dart'; */
import 'package:appanimals/models/peces/listview_separated_fishes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Preferences.initShared();
  await dotenv.load(fileName: ".env");

  runApp(MultiProvider(
    providers: [
  
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
      /* initialRoute: '/home', */
      title: 'App Animals',
      routes: {
        '/buscar': (context) => BuscarScreen(),  // Define otras rutas
        '/perfiles': (context) => ListViewSeparatedScreen(),
        '/animals': (context) => const AnimalScreen(),
        '/list_fishes': (context) => const ListViewSeparatedScreen(),
      },
    );
  }
}