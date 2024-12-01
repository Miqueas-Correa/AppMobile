import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appanimals/data/profile_data.dart';
import 'package:appanimals/providers/theme_provider.dart';
import 'package:appanimals/widgets/profile_detail_card.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';

class ProfileDetailScreen extends StatefulWidget {
  final int perfil;
  final String name;
  final String imagen;
  final String name;
  final String imagen;

  const ProfileDetailScreen({
    super.key,
    required this.perfil,
    required this.name,
    required this.imagen,
  });

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  final TextEditingController feedbackController = TextEditingController();

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isLightTheme = themeProvider.currentTheme == ThemeData.light();
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isLightTheme = themeProvider.currentTheme == ThemeData.light();

        // Colores según el tema
        const titleColor = Colors.white;
        final textColor = isLightTheme ? Colors.black : Colors.white;
        final inputBorderColor = isLightTheme ? const Color(0xFFC0BABA) : const Color(0xFF3D3C3C);
        final iconColor = isLightTheme ? const Color.fromARGB(255, 21, 100, 21) : const Color.fromARGB(255, 21, 100, 21);
        final backgroundColor = isLightTheme ? Colors.white : Colors.black;
        final cardColor = isLightTheme
            ? Colors.grey.withOpacity(0.1)
            : Colors.grey.withOpacity(0.3);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.name,
              style: const TextStyle(color: titleColor),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 21, 100, 21),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: 'avatar_${widget.perfil}',
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 21, 100, 21), // Borde verde
                          width: 5, // Grosor del borde (ajustado a 6)
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage(widget.imagen),
                        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SwitchListTile.adaptive(
                  title: Text(
                    'Modo Claro/Oscuro',
                    style: TextStyle(color: textColor),
                  ),
                  value: isLightTheme,
                  onChanged: (value) {
                    // Llamamos al método correspondiente según el valor del switch
                    value ? themeProvider.setLight() : themeProvider.setDark();
                  },
                  secondary: Icon(
                    isLightTheme ? Icons.wb_sunny : Icons.nightlight_round,
                    color: iconColor,
                  ),
                ),
                const SizedBox(height: 20),
                ...[
                  ProfileDetailCard(
                    icon: Icons.person,
                    label: 'Nombre',
                    value:
                        '${profileData[widget.perfil]!['nombre']} ${profileData[widget.perfil]!['apellido']}',
                    textColor: textColor,
                    iconColor: iconColor,
                    cardColor: cardColor,
                  ),
                  ProfileDetailCard(
                    icon: Icons.email,
                    label: 'Email',
                    value: profileData[widget.perfil]!['email']!,
                    textColor: textColor,
                    iconColor: iconColor,
                    cardColor: cardColor,
                  ),
                  ProfileDetailCard(
                    icon: Icons.phone,
                    label: 'Teléfono',
                    value: profileData[widget.perfil]!['telefono']!,
                    textColor: textColor,
                    iconColor: iconColor,
                    cardColor: cardColor,
                  ),
                  ProfileDetailCard(
                    icon: Icons.credit_card,
                    label: 'DNI',
                    value: profileData[widget.perfil]!['dni']!,
                    textColor: textColor,
                    iconColor: iconColor,
                    cardColor: cardColor,
                  ),
                  ProfileDetailCard(
                    icon: Icons.info,
                    label: 'Sobre Nosotros',
                    value: profileData[widget.perfil]!['sobreNosotros']!,
                    textColor: textColor,
                    iconColor: iconColor,
                    cardColor: cardColor,
                  ),
                ].expand((card) => [card, const SizedBox(height: 10)]),
                TextField(
                  controller: feedbackController,
                  maxLines: 3,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: '¿Qué le pareció nuestra app?',
                    labelStyle: TextStyle(color: inputBorderColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inputBorderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textColor),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final opinion = feedbackController.text.trim();
                      if (opinion.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, ingrese su opinión.'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Opinión guardada: $opinion'),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 21, 100, 21)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Text('Guardar Opinión'),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const BotoneraNavigation(),
        );
      },
    );
  }
  }
}