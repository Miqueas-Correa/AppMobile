import 'package:flutter/material.dart';
import 'package:appanimals/screens/home_screen.dart';
import 'package:appanimals/screens/peces/peces_list_screen.dart';
import 'package:appanimals/widgets/custom_outlined_button.dart';

class AnimalHistory extends StatelessWidget {
  final String title;
  final String text;

  const AnimalHistory({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: const Color.fromARGB(255, 21, 100, 21),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Título del animal
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                wordSpacing: 4,
                height: 1.5,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            // Texto adicional sobre el animal
            Text(
              text,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white,
                wordSpacing: 4,
                height: 1.5,
              ),
            ),
            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomOutlinedButton(
                  text: 'Ir al inicio',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
                CustomOutlinedButton(
                  text: 'Ver listado',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PecesListScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
