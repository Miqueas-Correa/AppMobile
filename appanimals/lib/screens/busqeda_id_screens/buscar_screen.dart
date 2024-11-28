import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/models/categories_model.dart';
import 'package:appanimals/widgets/category_card.dart';
import 'package:appanimals/screens/busqeda_id_screens/animal_detail_screen.dart';

class BuscarScreen extends StatelessWidget {
  BuscarScreen({super.key});
  
  final List<Category> categories = [
    Category(
        title: 'cats',
        imagePath: 'assets/images/buscar_page/gato_2.jpg',
        color: Colors.white),
    Category(
        title: 'dogs',
        imagePath: 'assets/images/buscar_page/perro_2.jpg',
        color: Colors.white),
    Category(
        title: 'peces',
        imagePath: 'assets/images/buscar_page/pez_2.jpg',
        color: Colors.white),
    Category(
        title: 'crocodriles',
        imagePath: 'assets/images/buscar_page/cocodriloo_2.jpg',
        color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    // Determina si el tema actual es claro u oscuro
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    // Establece colores segun el tema
    final backgroundColor = isLightTheme ? Colors.white : Colors.black;
    final buttonColor = isLightTheme
        ? const Color.fromARGB(255, 21, 100, 21)
        : const Color.fromARGB(255, 21, 100, 21);

    return Scaffold(
      backgroundColor:
          backgroundColor, // Uso el color de fondo basado en el tema
      appBar: AppBar(
        backgroundColor:
            buttonColor, // Cambio el color del AppBar segun el tema
        title: Text(
          'Seleccione el animal que quiere buscar:',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white), // Texto adaptado al tema
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columnas
            crossAxisSpacing: 10, // Espacio horizontal entre celdas
            mainAxisSpacing: 10, // Espacio vertical entre celdas
          ),
          itemBuilder: (context, index) {
            final category =
                categories[index]; // Obtiene la categoria en el iindice actual
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimalDetailScreen(
                        animal: category), // Pasa la categoriia seleccionada
                  ),
                );
              },
              child: CategoryCard(
                title: category.title,
                imagePath: category.imagePath,
                color: category.color,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BotoneraNavigation(),
    );
  }
}
