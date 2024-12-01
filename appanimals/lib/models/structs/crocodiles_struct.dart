import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CrocodileStruct(
    Map<String, dynamic> data, bool isFavorite, VoidCallback onFavoriteToggle) {
  // final Map<String, dynamic> data = apiResponse['data'] ?? {}; // Asegura que se use la clave 'data'

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
            'Nombre: ${data['name']}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Color: ${data['color']}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Habitat: ${data['habitat']}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'ID: ${data['id']}',
            style: const TextStyle(fontSize: 18),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: onFavoriteToggle,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}