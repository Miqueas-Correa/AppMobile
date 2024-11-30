import 'package:appanimals/screens/gatos/cats_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/models/cats/cats_model.dart';

class CatsListItem extends StatelessWidget {
  final Cat cat;

  const CatsListItem({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Aquí navegas al detalle del gato
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CatsDetailScreen(cat: cat),
          ),
        );
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(cat.avatar),
        ),
        title: Text(cat.nombre),
        subtitle: Text('Color: ${cat.color}'),
        trailing: Icon(
          cat.favorito ? Icons.favorite : Icons.favorite_border,
          color: cat.favorito ? Colors.red : Colors.grey,
        ),
      ),
    );
  }
}
