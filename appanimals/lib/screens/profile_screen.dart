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

    // Definir el color de las flechas según el tema
    final arrowColor = isLightTheme ? Colors.black : Colors.white;
    final titleColor = isLightTheme ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfiles', style: TextStyle(color: titleColor),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: nombres.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(imagenes[index]), // Imagen del perfil
            ),
            title: Text(nombres[index]),
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
          );
        },
      ),
    );
  }
}
