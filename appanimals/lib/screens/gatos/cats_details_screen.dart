import 'package:appanimals/models/cats/cats_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatsDetailsScreen extends StatefulWidget {
  final Cats cat;
  final String avatarPath;

  const CatsDetailsScreen({
    super.key,
    required this.cat,
    required this.avatarPath,
  });

  @override
  _CatsDetailsScreen createState() => _CatsDetailsScreen();
}

class _CatsDetailsScreen extends State<CatsDetailsScreen> {
  late Cats _cats;
  late TextEditingController _nameController;
  late TextEditingController _razaController;
  late TextEditingController _colorController;

  @override
  void initState() {
    super.initState();
    _cats = widget.cat;
    _loadFavorite();

    //inicializa
    _nameController = TextEditingController(text: _cats.nombre);
    _razaController = TextEditingController(text: _cats.raza);
    _colorController = TextEditingController(text: _cats.color);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _razaController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  Future<void> _loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorite = prefs.getBool(_cats.id.toString()) ?? false;
    setState(() {
      _cats.favorite = favorite;
    });
  }

  Future<void> _toggleFavorite(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_cats.id.toString(), value);
    setState(() {
      _cats.favorite = value;
    });
  }

  Future<void> _updateRating(double rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('${_cats.id}_rating', rating);
    setState(() {
      _cats.stars = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil del gato'),
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
                cats: _cats,
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
  final Cats cats;
  final ValueChanged<bool> onFavoriteChanged;
  final ValueChanged<double> onRatingChanged;

  const BodyProfileCustomItem({
    super.key,
    required this.cats,
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
          value: cats.favorite,
          onChanged: onFavoriteChanged,
        ),
        const SizedBox(height: 20),
        DataRow(
            title: 'Nombre',
            controller: TextEditingController(text: cats.nombre)),
        DataRow(
            title: 'Raza',
            controller: TextEditingController(text: cats.raza)),
        DataRow(
            title: 'Color',
            controller: TextEditingController(text: cats.color)),
        const SizedBox(height: 20),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                onRatingChanged(index + 1.0);
              },
              child: Icon(
                index < cats.stars ? Icons.star : Icons.star_border,
                color: const Color.fromARGB(255, 21, 100, 21),
                size: 40,
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Text(
          'Calificación: ${cats.stars.toStringAsFixed(1)}',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class DataRow extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const DataRow({super.key, required this.title, required this.controller});

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
                    'assets/images/gatos_listado/gato1.jpg',
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
