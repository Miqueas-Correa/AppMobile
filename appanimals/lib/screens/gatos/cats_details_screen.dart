import 'package:flutter/material.dart';
import 'package:appanimals/models/cats/cats_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color appGreenColor = Color.fromARGB(255, 21, 100, 21);
const double avatarSize = 200.0;

class CatsDetailScreen extends StatefulWidget {
  final Cat cat;

  const CatsDetailScreen({super.key, required this.cat});

  @override
  _CatsDetailScreenState createState() => _CatsDetailScreenState();
}

class _CatsDetailScreenState extends State<CatsDetailScreen> {
  late Cat _cat;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _cat = widget.cat;
    _noteController = TextEditingController();
    _loadFavorite();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorite = prefs.getBool(_cat.id.toString()) ?? false;
    setState(() {
      _cat.favorito = favorite;
    });
  }

<<<<<<< HEAD
  Future<void> _saveFavorite(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_cat.id.toString(), value);
  }

  void _updateRating(double rating) {
    setState(() {
      _cat.estrella = rating;
=======
  Future<void> _toggleFavorite(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_cats.id.toString(), value);
    setState(() {
      _cats.favorite = value;
>>>>>>> origin/dev
    });
  }

  Future<void> _updateRating(double rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('${_cats.id}_rating', rating);
    setState(() {
<<<<<<< HEAD
      _cat.favorito = value;
=======
      _cats.stars = rating;
>>>>>>> origin/dev
    });
    _saveFavorite(value);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil del Gato'),
        backgroundColor: appGreenColor,
        foregroundColor: Colors.white,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderProfileCustomItem(size: size, avatar: _cat.avatar),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BodyProfileCustomItem(
                cat: _cat,
                onFavoriteChanged: _toggleFavorite,
                onRatingChanged: _updateRating,
                noteController: _noteController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyProfileCustomItem extends StatelessWidget {
  final Cat cat;
  final ValueChanged<bool> onFavoriteChanged;
  final ValueChanged<double> onRatingChanged;
  final TextEditingController noteController;

  const BodyProfileCustomItem({
    super.key,
    required this.cat,
    required this.onFavoriteChanged,
    required this.onRatingChanged,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile.adaptive(
          title: const Text('Favorito'),
          value: cat.favorito,
          onChanged: onFavoriteChanged,
        ),
        const SizedBox(height: 20),
        DataRow(title: 'Nombre', data: cat.nombre),
        DataRow(title: 'Color', data: cat.color),
        DataRow(title: 'Raza', data: cat.raza),
        DataRow(title: 'ID', data: cat.id.toString()),
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
                index < cat.estrella ? Icons.star : Icons.star_border,
                color: Colors.yellow,
                size: 40,
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Text(
          'Calificación: ${cat.estrella.toStringAsFixed(1)}',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
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
  final String? avatar;

  const HeaderProfileCustomItem({super.key, required this.size, this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      color: appGreenColor,
      child: Center(
        child: Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 5,
            ),
          ),
          child: ClipOval(
            child: avatar != null && avatar!.isNotEmpty
                ? Image.network(
                    avatar!,
                    fit: BoxFit.cover,
                    width: avatarSize,
                    height: avatarSize,
                  )
                : Image.asset(
                    'assets/images/buscar_page/gato_2.jpg',
                    fit: BoxFit.cover,
                    width: avatarSize,
                    height: avatarSize,
                  ),
          ),
        ),
      ),
    );
  }
}
