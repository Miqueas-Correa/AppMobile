import 'package:flutter/material.dart';
import 'package:appanimals/models/cats_model.dart';

class CatsListItem extends StatelessWidget{
  final CatsModel cat;

  const CatsListItem({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: cat.avatar != null 
        ? CircleAvatar(
          backgroundImage: NetworkImage(cat.avatar!),
          radius: 30,
        )
        : CircleAvatar(
          radius: 30,
          child: Icon(Icons.pets),
        ),
        title: Text(cat.nombre ?? 'Sin nombre'),
        subtitle: Text(
                    '${cat.raza ?? 'Sin raza'} - ${cat.color ?? 'Sin color'}\n'
                    'Cazador: ${cat.cazador ?? 'No especificado'}',
                    style: const TextStyle(fontSize: 12),
                  ),
      ),
    );
  }
}