import 'package:appanimals/models/peces/fishes_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FishesDetailScreen extends StatefulWidget {
  final Fishes fishes;
  final String avatarPath;

  const FishesDetailScreen({
    super.key,
    required this.fishes,
    required this.avatarPath,
  });

  @override
  _FishesDetailScreenState createState() => _FishesDetailScreenState();
}

class _FishesDetailScreenState extends State<FishesDetailScreen> {
  late Fishes _fishes;
  late TextEditingController _nameController;
  late TextEditingController _speciesController;
  late TextEditingController _colorController;

  @override
  void initState() {
    super.initState();
    _fishes = widget.fishes;
    _loadFavorite();

    //inicializa
    _nameController = TextEditingController(text: _fishes.nombre);
    _speciesController = TextEditingController(text: _fishes.especie);
    _colorController = TextEditingController(text: _fishes.color);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _speciesController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  Future<void> _loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorite = prefs.getBool(_fishes.id.toString()) ?? false;
    setState(() {
      _fishes.favorite = favorite;
    });
  }

  Future<void> _updateRating(double rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('${_fishes.id}_rating', rating);
    setState(() {
      _fishes.stars = rating;
    });
  }

  Future<void> _toggleFavorite(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fishes.favorite = value;
    });
    await prefs.setBool(_fishes.id.toString(), _fishes.favorite);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil del pez'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderProfileCustomItem(
              size: size,
              avatarPath: widget.avatarPath,
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
          title: const Text('Favorito',
              style: TextStyle(fontWeight: FontWeight.bold)),
          value: fishes.favorite,
          onChanged: onFavoriteChanged,
        ),
        const SizedBox(height: 20),
        DataRow(
            title: 'Nombre',
            controller: TextEditingController(text: fishes.nombre)),
        DataRow(
            title: 'Especie',
            controller: TextEditingController(text: fishes.especie)),
        DataRow(
            title: 'Color',
            controller: TextEditingController(text: fishes.color)),
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
                color: const Color.fromARGB(255, 21, 100, 21),
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
  final TextEditingController controller;

  const DataRow({
    super.key, 
    required this.title, 
    required this.controller
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
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: decorationInput(
                  label: title,
                  hintText: 'Ingresa $title',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//inputs del textformfield
InputDecoration decorationInput(
    {IconData? icon, String? hintText, String? helperText, String? label}) {
  return InputDecoration(
    fillColor: Colors.black,
    label: Text(label ?? ''),
    hintText: hintText,
    helperText: helperText,
    helperStyle: const TextStyle(fontSize: 16),
    prefixIcon: icon != null ? Icon(icon) : null,
  );
}

class HeaderProfileCustomItem extends StatelessWidget {
  final Size size;
  final String avatarPath;

  const HeaderProfileCustomItem({
    super.key,
    required this.size,
    required this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      color: const Color.fromARGB(255, 58, 133, 58),
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color.fromARGB(255, 21, 100, 21),
              width: 2,
            ),
          ),
          child: ClipOval(
            child: avatarPath.isNotEmpty
                ? Image.asset(
                    avatarPath,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  )
                : Image.asset(
                    'assets/images/avatars_peces/avatar1.png',
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
