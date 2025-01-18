import 'package:flutter/material.dart';
import 'package:appanimals/widgets/widgets.dart';
import 'package:appanimals/screens/screens.dart';

class ProfilesScreen extends StatelessWidget {
  ProfilesScreen({super.key});

  final List<String> nombres = [
    'Matías Coronel Dittler',
    'Miqueas Correa',
    'Wanda Suarez',
    'Brenda Yañez'
  ];

  final List<String> imagenes = [
    'assets/images/profiles/Matias.jpeg',
    'assets/images/profiles/Mikeas.jpeg',
    'assets/images/profiles/Wanda.jpeg',
    'assets/images/profiles/Brenda.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    // Obtener el tema actual para aplicar el estilo adecuado
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final borderColor = isLightTheme ? const Color(0xFFC0BABA) : const Color(0xFF3D3C3C);
    final shadowColor = isLightTheme ? const Color(0xFFC0BABA) : const Color(0xFF3D3C3C);
    final arrowColor = isLightTheme ? const Color(0xFFC0BABA) : const Color(0xFF3D3C3C);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfiles'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: nombres.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Card(
              color: isLightTheme ? Colors.white : Colors.black,
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
                title: Text(nombres[index],
                    style: TextStyle(
                        color: isLightTheme ? Colors.black : Colors.white)),
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
