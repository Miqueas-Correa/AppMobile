import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appanimals/provider/theme_provider.dart';
import 'package:appanimals/screens/profile_detail_screen.dart';
import 'package:appanimals/themes/default_theme.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLightTheme = themeProvider.temaActual == DefaultTheme.lightTheme;

    final arrowColor = isLightTheme ? Colors.black : Colors.white;
    final titleColor = isLightTheme ? Colors.black : Colors.white;
    final borderColor = isLightTheme ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfiles', style: TextStyle(color: Colors.white)),
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
              shadowColor: isLightTheme ? Colors.black45 : Colors.white54,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(imagenes[index]),
                ),
                title: Text(nombres[index], style: TextStyle(color: titleColor)),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: arrowColor,
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
                  ).then((_) {
                    Navigator.popUntil(context, ModalRoute.withName('/home'));
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
