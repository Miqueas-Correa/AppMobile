import 'package:flutter/material.dart';

class AcercaDePage extends StatelessWidget {
  const AcercaDePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Acerca de'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // flecha q vuelve para atras
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
      ),
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
                    fit: BoxFit.cover,
                    height:
                        MediaQuery.of(context).size.height, // Ajusta la altura
                    width: MediaQuery.of(context).size.width, // Ajusta el ancho
                  ),
                ),
              ),

              //DESCRIPCION APP+ANIMACIONES
              const AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Descripcion de la App:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Text(
                      'Esta aplicacion tiene como objetivo informar sobre los animales en la fauna que esta en peligro de extincion.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              // SOBRE NOSOTROSSSSSSSSSSSS
              const AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Sobre Nosotros:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Text(
                      'Somos un grupo de desarrolladores que decidimos crear esta aplicacion para concientizar a las personas sobre la importancia de proteger las especies en peligro.',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),

              // BOTON DE MAS INFOOOOO
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
                                child: const Text('Cerrar'),
                              ),
                            ],
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 21, 100, 21),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Mas Info', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 10),

              //SECIION DE CONTACTOOOO
              const AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contacto:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Suarezwanda00@gmail.com \nmiki.mate.tizi@gmail.com \nbrendayw97@gmail.com \nDittler_matias@yahoo.com ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 40, 243, 33)),
                    ),
                    SizedBox(height: 2),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
