import 'package:appanimals/models/dogs_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DogsDetailScreen extends StatefulWidget {
  final DogsModel dog;

  const DogsDetailScreen({super.key, required this.dog});

  @override
  _DogsDetailScreenState createState() => _DogsDetailScreenState();
}

class _DogsDetailScreenState extends State<DogsDetailScreen> {
  late DogsModel _dog;

  @override
  void initState() {
    super.initState();
    _dog = widget.dog;
    _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorite = prefs.getBool(_dog.id.toString()) ?? false;
    setState(() {
      _dog.favorite = favorite;
    });
  }

  Future<void> _saveFavorite(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_dog.id.toString(), value);
  }

  void _updateRating(double rating) {
    setState(() {
      _dog.stars = rating;
    });
  }

  void _toggleFavorite(bool value) {
    setState(() {
      _dog.favorite = value;
    });
    _saveFavorite(value);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil del perro'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderProfileCustomItem(
              size: size,
              nombre: _dog.nombre,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BodyProfileCustomItem(
                dog: _dog,
                onFavoriteChanged: _toggleFavorite,
                onRatingChanged: _updateRating,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyProfileCustomItem extends StatelessWidget {
  final DogsModel dog;
  final ValueChanged<bool> onFavoriteChanged;
  final ValueChanged<double> onRatingChanged;

  const BodyProfileCustomItem({
    super.key,
    required this.dog,
    required this.onFavoriteChanged,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile.adaptive(
          title: const Text('Favorito'),
          value: dog.favorite,
          onChanged: onFavoriteChanged,
        ),
        const SizedBox(height: 20),
        DataRow(title: 'Id: ', data: dog.id),
        DataRow(title: 'Nombre: ', data: dog.nombre),
        DataRow(title: 'Raza: ', data: dog.raza),
        DataRow(title: 'Fecha de nacimiento: ', data: dog.fechaNacimiento),
        const SizedBox(height: 20),
        // Calificación con estrellas
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                onRatingChanged(index + 1.0);
              },
              child: Icon(
                index < dog.stars ? Icons.star : Icons.star_border,
                color: Colors.yellow,
                size: 40,
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Text(
          'Calificación: ${dog.stars.toStringAsFixed(1)}',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class DataRow extends StatelessWidget {
  final String title;
  final String data;

  const DataRow({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              data,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderProfileCustomItem extends StatelessWidget {
  final Size size;
  final String? nombre;

  const HeaderProfileCustomItem({super.key, required this.size, this.nombre});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      color: const Color.fromARGB(255, 21, 100, 21),
      child: Center(
        child: Container(
          width: 200, // Tamaño del círculo
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white, // Color del borde
              width: 5, // Grosor del borde
            ),
          ),
          child: ClipOval(
            child: nombre != null && nombre!.isNotEmpty
                ? Image.network(
                    nombre!,
                    fit: BoxFit
                        .cover, // Ajuste para que la imagen cubra todo el círculo
                    width:
                        200, // Asegura que la imagen ocupe todo el espacio disponible
                    height:
                        200, // Asegura que la imagen ocupe todo el espacio disponible
                  )
                : Image.asset(
                    'assets/images/profiles/dog_profile.jpeg',
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
          ),
        ),
      ),
    );
  }
}
