import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget FishesStruct(
    Map<String, dynamic> data, bool isFavorite, VoidCallback onFavoriteToggle) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nombre: ${data['nombre']}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Especie: ${data['especie']}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Color: ${data['color']}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Id: ${data['id']}',
            style: const TextStyle(fontSize: 18),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: onFavoriteToggle,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? const Color.fromARGB(255, 21, 100, 21) : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}