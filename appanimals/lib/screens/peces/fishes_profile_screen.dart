import 'package:appanimals/models/peces/fishes_model.dart';
import 'package:appanimals/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FishesDetailScreen extends StatefulWidget {
  final Fishes fishes;

  const FishesDetailScreen({
    super.key, 
    required this.fishes});

  @override
  _FishesDetailScreenState createState() => _FishesDetailScreenState();
}

class _FishesDetailScreenState extends State<FishesDetailScreen> {
  late Fishes _fishes;

  @override
  void initState() {
    super.initState();
    _fishes = widget.fishes;
    _loadFavorite(); 
  }

  Future<void> _loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorite = prefs.getBool(_fishes.id.toString()) ?? false;
    setState(() {
      _fishes.favorite = favorite;
    });
  }

  Future<void> _saveFavorite(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_fishes.id.toString(), value);
  }

  void _updateRating(double rating) {
    setState(() {
      _fishes.stars = rating;
    });
  }

  void _toggleFavorite(bool value) {
    setState(() {
      _fishes.favorite = value;
    });
    _saveFavorite(value);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil del Pez'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
        elevation: 10,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderProfileCustomItem(
              size: size,
              avatar: _fishes.avatar,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BodyProfileCustomItem(
                fishes: _fishes,
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
  final Fishes fishes;
  final ValueChanged<bool> onFavoriteChanged;
  final ValueChanged<double> onRatingChanged;

  const BodyProfileCustomItem({
    super.key,
    required this.fishes,
    required this.onFavoriteChanged,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile.adaptive(
          title: const Text('Favorito'),
          value: fishes.favorite,
          onChanged: onFavoriteChanged,
        ),
        const SizedBox(height: 20),
        DataRow(title: 'Nombre', data: fishes.nombre),
        DataRow(title: 'Color', data: fishes.color),
        DataRow(title: 'Especie', data: fishes.especie),
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
                index < fishes.stars ? Icons.star : Icons.star_border,
                color: const Color.fromARGB(255, 21, 100, 21), //cambiar
                size: 40,
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Text(
          'Calificación: ${fishes.stars.toStringAsFixed(1)}',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class DataRow extends StatelessWidget {
  final String title;
  final String data;

  const DataRow({
    super.key, 
    required this.title, 
    required this.data
  });

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
  final String? avatar;

  const HeaderProfileCustomItem({
    super.key, 
    required this.size, 
    this.avatar
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      color: const Color.fromARGB(255, 21, 100, 21),
      child: Center(
        child: Container(
          width: 200,  // Tamaño del círculo
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,  // Color del borde
              width: 5,  // Grosor del borde
            ),
          ),
          child: ClipOval(
            child: avatar != null && avatar!.isNotEmpty
                ? Image.network(
                    avatar!,
                    fit: BoxFit.cover,  // Ajuste para que la imagen cubra todo el círculo
                    width: 200,  // Asegura que la imagen ocupe todo el espacio disponible
                    height: 200, // Asegura que la imagen ocupe todo el espacio disponible
                  )
                : Image.asset(
                    'assets/images/peces.png',
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