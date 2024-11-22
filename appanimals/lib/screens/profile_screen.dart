import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Asegúrate de tener provider importado
import 'package:appanimals/provider/theme_provider.dart';
import 'package:appanimals/screens/profile_detail_screen.dart';
import 'package:appanimals/themes/default_theme.dart'; // Asegúrate de tener este archivo

class ProfilesScreen extends StatelessWidget {
  ProfilesScreen({super.key});

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
    // Obtener el tema actual
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLightTheme = themeProvider.temaActual == DefaultTheme.lightTheme;

    // Definir los colores para los bordes, sombras y texto según el tema
    final borderColor = isLightTheme ? Colors.black : Colors.white;  // Borde negro en modo claro, blanco en modo oscuro
    final shadowColor = isLightTheme ? Colors.black.withOpacity(0.2) : Colors.white.withOpacity(0.2);
    final titleColor = isLightTheme ? Colors.black : Colors.white;
    final arrowColor = isLightTheme ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfiles',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 21, 100, 21), // Barra verde
      ),
      body: ListView.builder(
        itemCount: nombres.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              color: isLightTheme ? Colors.white : Colors.black54, // Fondo de la tarjeta
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: borderColor, width: 2), // Borde dinámico
              ),
              elevation: 8, // Mayor sombra para dar el efecto de profundidad
              shadowColor: shadowColor, // Sombra según el tema
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(imagenes[index]), // Imagen del perfil
                ),
                title: Text(nombres[index], style: TextStyle(color: titleColor)),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: arrowColor, // Aquí cambiamos el color de la flecha
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => ProfileDetailScreen(
                        perfil: index + 1,
                        name: nombres[index],
                        imagen: imagenes[index],
                      ),
                      transitionsBuilder: (_, anim, __, child) {
                        return FadeTransition(
                          opacity: anim,
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
