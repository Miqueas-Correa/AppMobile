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
            'Created At: ${data['createdAt']}',
            style: const TextStyle(fontSize: 18),
          ),
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
            'avatar: ${data['avatar']}',
            style: const TextStyle(fontSize: 18),
          ),
          // const SizedBox(height: 10),
          // Center(
          //   child: CircleAvatar(
          //     radius: 40,
          //     backgroundImage: _getAvatarImage(data['avatar']),
          //     backgroundColor: Colors.grey[200],
          //     child: (data['avatar'] == null || data['avatar'].isEmpty)
          //         ? const Icon(Icons.person, size: 40, color: Colors.grey)
          //         : null,
          //   ),
          // ),
          // const SizedBox(height: 10),
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

// ImageProvider _getAvatarImage(String? avatarUrl) {
//   if (avatarUrl != null && avatarUrl.isNotEmpty) {
//     return NetworkImage(avatarUrl); // Imagen desde la URL
//   }
//   return const AssetImage(
//       'assets/images/default_avatar.png'); // Imagen predeterminada
// }
