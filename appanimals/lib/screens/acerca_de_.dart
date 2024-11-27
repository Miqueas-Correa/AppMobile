import 'package:appanimals/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class AcercaDePage extends StatelessWidget {
  const AcercaDePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtiene el tema actual
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    // Colores según el tema
    final backgroundColor = isLightTheme ? Colors.white : Colors.black;
    final textColor = isLightTheme ? Colors.black : Colors.white;
    final buttonColor = isLightTheme ? const Color.fromARGB(255, 21, 100, 21) : Colors.green;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Acerca de'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
      ), drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(seconds: 10),
                child: Center(
                  child: Image.asset(
                    'assets/images/acerca_de_screens/exintos_acerca_De.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              //DESCRIPCION APP
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(seconds: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Descripcion de la App:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'Esta aplicacion tiene como objetivo informar sobre los animales en la fauna que esta en peligro de extincion.',
                      style: TextStyle(fontSize: 18, color: textColor),
                    ),
                  ],
                ),
              ),

              // SOBRE NOSOTROS
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(seconds: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Sobre Nosotros:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'Somos un grupo de desarrolladores que decidimos crear esta aplicacion para concientizar a las personas sobre la importancia de proteger las especies en peligro.',
                      style: TextStyle(fontSize: 18, color: textColor),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // BOTON DE MAS INFO
              AnimatedScale(
                scale: 1.0,
                duration: const Duration(milliseconds: 200),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Mas Info'),
                            content: const Text(
                              'Esta aplicación tiene como objetivo educar sobre la fauna en peligro de extinción y cómo podemos ayudar a protegerla. ¡Explora más y súmate al cambio!',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cerrar', selectionColor: Colors.black,),
                              ),
                            ],
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Mas Info', style: TextStyle(fontSize: 18), selectionColor: Colors.green,),
                ),
              ),
              const SizedBox(height: 10),

              // SECCION DE CONTACTO
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(seconds: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contacto:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Suarezwanda00@gmail.com \nmiki.mate.tizi@gmail.com \nbrendayw97@gmail.com \nDittler_matias@yahoo.com ',
                      style: TextStyle(
                        fontSize: 18,
                        color: isLightTheme
                            ? const Color.fromARGB(255, 40, 243, 33)
                            : Colors.greenAccent,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
