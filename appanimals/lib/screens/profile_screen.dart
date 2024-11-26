import 'package:flutter/material.dart';
import 'package:appanimals/screens/profile_detail_screen.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:provider/provider.dart';
import 'package:appanimals/providers/theme_provider.dart';

class ProfilesScreen extends StatelessWidget {
  ProfilesScreen({super.key});

  final List<String> nombres = [
    'Matías Emanuel Coronel Hittler',
    'Mikeas Hugo Ezequiel Correa',
    'Wanda Yasmin Suarez',
    'Brenda Anabella Yañez Wagner'
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
        actions: [
          // IconButton para cambiar entre temas
          IconButton(
            icon: Icon(isLightTheme ? Icons.wb_sunny : Icons.nightlight_round), // Cambiar ícono según el tema
            onPressed: () {
              // Cambiar entre temas claro y oscuro
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
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
                  );
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
