import 'package:flutter/material.dart';
import 'package:appanimals/screens/profile_detail_screen.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';

class ProfilesScreen extends StatelessWidget {
  final GlobalKey<BotoneraNavigationState> botoneraKey;

  ProfilesScreen({super.key, required this.botoneraKey});

  final List<String> nombres = [
    'Matías Emanuel Coronel Dittler',
    'Mikeas Hugo Ezequiel Correa',
    'Wanda Yazmin Suares',
    'Brenda Anabela Yañez Wagner'
  ];

  final List<String> imagenes = [
    'assets/images/Matias.jpeg',
    'assets/images/Mikeas.jpeg',
    'assets/images/wanda.jpeg',
    'assets/images/Brenda.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    // Obtener el tema actual para aplicar el estilo adecuado
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final borderColor = isLightTheme ? Colors.black : Colors.white;
    final shadowColor = isLightTheme ? Colors.black45 : Colors.white54;
    final arrowColor = isLightTheme ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfiles'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
      ),
      body: ListView.builder(
        itemCount: nombres.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              color: isLightTheme ? Colors.white : Colors.black54,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: borderColor,
                  width: 2,
                ),
              ),
              elevation: 5,
              shadowColor: shadowColor,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(imagenes[index]),
                ),
                title: Text(nombres[index], style: TextStyle(color: isLightTheme ? Colors.black : Colors.white)),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: arrowColor, // Aquí se aplica el color de la flecha
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileDetailScreen(
                        perfil: index + 1,
                        name: nombres[index],
                        imagen: imagenes[index],
                      ),
                    ),
                  ).then((_) {
                    // Después de regresar, actualizamos el índice del BottomNavigationBar
                    botoneraKey.currentState?.cambiarPagina(2); // Índice de "Perfiles"
                  });
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BotoneraNavigation(),
    );
  }
}
