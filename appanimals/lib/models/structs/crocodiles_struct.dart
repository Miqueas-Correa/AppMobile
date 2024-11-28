// import 'package:flutter/material.dart';

// // ignore: non_constant_identifier_names
// Widget CrocodileStruct(
//     Map<String, dynamic> data, bool isFavorite, VoidCallback onFavoriteToggle) {
//   return Card(
//     elevation: 5,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(15),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage(data['avatar']),
//                 radius: 30,
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Id: ${data['id']}',
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                     Text(
//                       'Nombre: ${data['name']}',
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 onPressed: onFavoriteToggle,
//                 icon: Icon(
//                   isFavorite ? Icons.favorite : Icons.favorite_border,
//                   color: isFavorite ? Colors.red : Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Color: ${data['color']}',
//             style: const TextStyle(fontSize: 18),
//           ),
//           Text(
//             'Habitat: ${data['habitat']}',
//             style: const TextStyle(fontSize: 18),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               const Text(
//                 'Calificación:',
//                 style: TextStyle(fontSize: 18),
//               ),
//               const SizedBox(width: 8),
//               _buildRatingStars(data['rating'] ?? 0),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildRatingStars(int rating) {
//   return Row(
//     children: List.generate(5, (index) {
//       return Icon(
//         index < rating ? Icons.star : Icons.star_border,
//         color: index < rating ? Colors.amber : Colors.grey,
//       );
//     }),
//   );
// }
