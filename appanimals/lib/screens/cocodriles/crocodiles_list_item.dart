import 'package:flutter/material.dart';

class CrocodilesListItem extends StatelessWidget {
  final Map<String, dynamic> args;


  const CrocodilesListItem({super.key, required this.args});


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil del cocodrilo'),
        backgroundColor: const Color.fromARGB(255, 100, 21, 21),
        foregroundColor: Colors.white,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderProfileCustomItem(
              size: size,
              avatar: args['avatar'],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BodyProfileCustomItem(args: args),
            ),
          ],
        ),
      ),
    );
  }
}


class BodyProfileCustomItem extends StatelessWidget {
  final Map<String, dynamic> args;


  const BodyProfileCustomItem({super.key, required this.args});


  @override


  Widget build(BuildContext context) {
    return Column(
      children: [
        // Favorito: Corazón que cambia de color
        IconButton(
          icon: Icon(
            args['favorite'] ? Icons.favorite : Icons.favorite_border,
            color: args['favorite'] ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            // Aquí deberías actualizar el estado del favorito en SharedPreferences o en el estado global
          },
        ),
        // Puntuación de estrellas: Mostrar estrellas según la calificación
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => Icon(
              index < args['stars']
                  ? Icons.star
                  : Icons.star_border,
              color: Colors.yellow,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Información con título
        DataCard(title: 'Especie', data: args['especie']),
        DataCard(title: 'Hábitat', data: args['habitat']),
        DataCard(title: 'Color', data: args['color']),
      ],
    );
  }
}


class DataCard extends StatelessWidget {
  final String title;
  final String? data;


  const DataCard({super.key, required this.title, required this.data});


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              data ?? 'Información no disponible',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}


class HeaderProfileCustomItem extends StatelessWidget {
  final Size size;
  final String? avatar;


  const HeaderProfileCustomItem({super.key, this.avatar, required this.size});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      color: const Color.fromARGB(216, 100, 21, 21),
      child: Center(
        child: CircleAvatar(
          radius: 100,
          backgroundColor: Colors.white,
          child: avatar != ""
              ? Image.asset('assets/avatars_crocodiles/$avatar.png')
              : Image.asset('assets/images/crocodile.png'),
        ),
      ),
    );
  }
}
