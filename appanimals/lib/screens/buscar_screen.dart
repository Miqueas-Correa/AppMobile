import 'package:flutter/material.dart';
import 'package:appanimals/models/categories_model.dart';
import 'package:appanimals/widgets/category_card.dart';
import 'package:appanimals/screens/animal_detail_screen.dart';

class BuscarScreen extends StatelessWidget{
  final List<Category> categories = [
    Category(title: 'Gato', imagePath: 'assets/images/buscar_page/gato_2.jpg', color: Colors.white),
    Category(title: 'Perro', imagePath: 'assets/images/buscar_page/perro_2.jpg', color: Colors.white),
    Category(title: 'Pez', imagePath: 'assets/images/buscar_page/pez_2.jpg', color: Colors.white),
    Category(title: 'Cocodrilo', imagePath: 'assets/images/buscar_page/cocodriloo_2.jpg', color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Seleccione el animal que quiere buscar:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // defino como se organizar las coulum y filas
            crossAxisCount: 2, // 2 columnas
            crossAxisSpacing: 10, // espacio entre elementos
            mainAxisSpacing: 10, // espacio vertical
          ), 
          itemBuilder: (context, index) { // defino cm se construye cd celda de colum y row
            final category = categories[index]; // obt categoria en el indice actual
            return GestureDetector( // detecto los click del user en este caso un toke/click
              onTap: () {
                Navigator.push( // navego a la pantalla de detakkes de animal
                  context,
                  MaterialPageRoute(
                    builder: (context)=> AnimalDetailScreen(animal: category), // paso la categoria seleccionada
                  )
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
    );
  }
}