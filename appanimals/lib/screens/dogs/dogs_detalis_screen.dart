import 'package:appanimals/models/dogs_model.dart';
import 'package:appanimals/widgets/botonera_navigation.dart';
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
  bool _isFavorite = false;
  bool _isLove = false;
  String _note = '';

  @override
  void initState() {
    super.initState();
    _dog = widget.dog;
    _loadFavoriteAndLove();
    _loadRating();
    _loadNote();
  }

  Future<void> _loadFavoriteAndLove() async {
    final prefs = await SharedPreferences.getInstance();
    final favorite = prefs.getBool(_dog.id.toString()) ?? false;
    final love = prefs.getBool('${_dog.id}_love') ?? false;
    setState(() {
      _isFavorite = favorite;
      _isLove = love;
    });
  }

  Future<void> _loadRating() async {
    final prefs = await SharedPreferences.getInstance();
    final rating = prefs.getDouble('${_dog.id}_rating') ?? 0.0;
    setState(() {
      _dog.stars = rating;
    });
  }

  Future<void> _loadNote() async {
    final prefs = await SharedPreferences.getInstance();
    final note = prefs.getString('${_dog.id}_note') ?? '';
    setState(() {
      _note = note;
    });
  }

  Future<void> _saveFavorite(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_dog.id.toString(), value);
  }

  Future<void> _saveLove(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${_dog.id}_love', value);
  }

  Future<void> _saveRating(double rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('${_dog.id}_rating', rating);
  }

  Future<void> _saveNote() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${_dog.id}_note', _note);
  }

  void _updateRating(double rating) {
    setState(() {
      _dog.stars = rating;
    });
    _saveRating(rating);
  }

  void _toggleFavoriteAndLove(bool value) {
    setState(() {
      _isFavorite = value;
      _isLove = value;
    });
    _saveFavorite(value);
    _saveLove(value);
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
                  isFavorite: _isFavorite,
                  isLove: _isLove,
                  onFavoriteAndLoveChanged: _toggleFavoriteAndLove,
                  onRatingChanged: _updateRating,
                  initialNote: _note,
                  onNoteChanged: (value) {
                    setState(() {
                      _note = value;
                    });
                    _saveNote();
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BotoneraNavigation(),
    );
  }
}

class BodyProfileCustomItem extends StatelessWidget {
  final DogsModel dog;
  final bool isFavorite;
  final bool isLove;
  final ValueChanged<bool> onFavoriteAndLoveChanged;
  final ValueChanged<double> onRatingChanged;
  final String initialNote;
  final ValueChanged<String> onNoteChanged;

  const BodyProfileCustomItem({
    super.key,
    required this.dog,
    required this.isFavorite,
    required this.isLove,
    required this.onFavoriteAndLoveChanged,
    required this.onRatingChanged,
    required this.initialNote,
    required this.onNoteChanged,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController noteController = TextEditingController();
    noteController.text = initialNote;

    return Column(
      children: [
        SwitchListTile.adaptive(
          title: const Text('Favorito'),
          value: dog.favorite,
          onChanged: onFavoriteAndLoveChanged,
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
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            controller: noteController,
            decoration: InputDecoration(
              labelText: 'Agregar nota',
              hintText: 'Escribe una nota sobre este perro',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: 3,
            onChanged: onNoteChanged,
          ),
        ),
        const SizedBox(height: 20),
        // Botón de guardar
        ElevatedButton(
          onPressed: () {
            final String note = noteController.text;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Nota guardada: $note'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 21, 100, 21),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: const Text('Guardar Nota',
              selectionColor: Color.fromARGB(255, 255, 255, 255)),
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
              style: const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 134, 132, 132)),
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
            child: Image.asset(
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
