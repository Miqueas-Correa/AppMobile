import 'package:appanimals/widgets/botonera_navigation.dart';
import 'package:flutter/material.dart';
import 'package:appanimals/models/crocodiles/crocodiles_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CrocodilesDetailScreen extends StatefulWidget {
  final Crocodile crocodile;
  final ValueChanged<Crocodile>? onFavoriteChanged;



  const CrocodilesDetailScreen({super.key, required this.crocodile,this.onFavoriteChanged});


  @override
  _CrocodilesDetailScreenState createState() => _CrocodilesDetailScreenState();
}


class _CrocodilesDetailScreenState extends State<CrocodilesDetailScreen> {
  late Crocodile _crocodile;
  bool _isFavorite = false;
  bool _isLove = false;
  String _note = '';


  @override
  void initState() {
    super.initState();
    _crocodile = widget.crocodile;
    _loadFavoritesAndLove();
    _loadRating(); // Cargar la calificación de estrellas
    _loadNote();
  }


  // Cargar 'favorite' y 'love' desde SharedPreferences
  Future<void> _loadFavoritesAndLove() async {
    final prefs = await SharedPreferences.getInstance();
    final favorite = prefs.getBool(_crocodile.id) ?? false; // Se usa 'id' como clave
    final love = prefs.getBool('${_crocodile.id}_love') ?? false; // Usamos id + '_love' como clave
    setState(() {
      _isFavorite = favorite;
      _isLove = love;
    });
  }


  // Cargar la calificación de estrellas desde SharedPreferences
  Future<void> _loadRating() async {
    final prefs = await SharedPreferences.getInstance();
    final rating = prefs.getDouble('${_crocodile.id}_rating') ?? 0.0; // Usamos id + '_rating' como clave
    setState(() {
      _crocodile.stars = rating;
    });
  }

  Future<void> _loadNote() async {
    final prefs = await SharedPreferences.getInstance();
    final note = prefs.getString('${_crocodile.id}_note') ?? ''; // Clave única para la nota
    setState(() {
      _note = note;
    });
  }

  Future<void> _saveFavorite(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_crocodile.id, value);
    setState(() {
    _crocodile.isFavorite = value;
    });
  }


  // Guardar 'love' en SharedPreferences
  Future<void> _saveLove(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${_crocodile.id}_love', value); // Guardamos 'love' usando id + '_love' como clave
  }
  

  // Guardar la calificación de estrellas en SharedPreferences
  Future<void> _saveRating(double rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('${_crocodile.id}_rating', rating); // Guardamos la calificación usando id + '_rating'
  }

  Future<void> _saveNote() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${_crocodile.id}_note', _note); // Guardar nota
  }

  void _updateRating(double rating) {
    setState(() {
      _crocodile.stars = rating;
    });
    _saveRating(rating); // Guardar la calificación de estrellas
  }


  // Cambiar el estado de 'favorite' y 'love'
  void _toggleFavoriteAndLove(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _crocodile.isFavorite = value;
      _isLove = value; // Cuando uno se activa o desactiva, ambos se actualizan
    });
    _saveFavorite(value); // Guardar el valor actualizado de 'favorite'
    _saveLove(value); // Guardar el valor actualizado de 'love'
    await prefs.setBool(_crocodile.id, value); // Guarda en SharedPreferences
    // Notifica el cambio a la lista
    if (widget.onFavoriteChanged != null) {
      widget.onFavoriteChanged!(_crocodile);
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil del Cocodrilo'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderProfileCustomItem(
              size: size,
              avatar: _crocodile.avatar,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BodyProfileCustomItem(
                crocodile: _crocodile,
                isFavorite: _crocodile.isFavorite,
                isLove: _isLove,
                onFavoriteAndLoveChanged: _toggleFavoriteAndLove,
                onRatingChanged: _updateRating,
                initialNote: _note, // Pasar la nota inicial
                onNoteChanged: (value) {
                  setState(() {
                    _note = value;
                  });
                  _saveNote(); // Guardar automáticamente cada vez que se edite
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BotoneraNavigation(), // Aquí se agrega la botonera
    );
  }
}


class BodyProfileCustomItem extends StatelessWidget {
  final Crocodile crocodile;
  final bool isFavorite;
  final bool isLove;
  final ValueChanged<bool> onFavoriteAndLoveChanged;
  final ValueChanged<double> onRatingChanged;
   final String initialNote;
  final ValueChanged<String> onNoteChanged; // Callback para cambios en la nota


  const BodyProfileCustomItem({
    super.key,
    required this.crocodile,
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
    noteController.text = initialNote; // Inicializar con la nota existente


    return Column(
      children: [
        SwitchListTile.adaptive(
          title: const Text('Favorito'),
          value: isFavorite,
          onChanged: onFavoriteAndLoveChanged,
        ),
        const SizedBox(height: 20),
        DataRow(title: 'Nombre', data: crocodile.name),
        DataRow(title: 'Color', data: crocodile.color),
        DataRow(title: 'Hábitat', data: crocodile.habitat),
        DataRow(title: 'id', data: crocodile.id),
        const SizedBox(height: 20),
        // Calificación con estrellas
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return MouseRegion(
              cursor: SystemMouseCursors.click, // Cambia el cursor al pasar sobre las estrellas
              child: GestureDetector(
                onTap: () {
                  onRatingChanged(index + 1.0); // Actualiza la calificación
                },
                child: Icon(
                  index < crocodile.stars ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                  size: 40,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Text(
          'Calificación: ${crocodile.stars.toStringAsFixed(1)}',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        // TextFormField para agregar notas o comentarios
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            controller: noteController,
            decoration: InputDecoration(
              labelText: 'Agregar nota',
              hintText: 'Escribe una nota sobre este cocodrilo',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: 3,
            onChanged: onNoteChanged, // Llamar al callback en cada cambio

          ),
        ),
        const SizedBox(height: 10),
        // Botón de guardar
        ElevatedButton(
          onPressed: () {
            // Aquí puedes guardar la nota utilizando _noteController.text
            final String note = noteController.text;
            // Implementar lógica de guardado
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
          child: const Text('Guardar Nota'),
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
  final String? avatar;


  const HeaderProfileCustomItem({super.key, required this.size, this.avatar});


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
            child: avatar != null && avatar!.isNotEmpty
                ? Image.network(
                    avatar!,
                    fit: BoxFit
                        .cover, // Ajuste para que la imagen cubra todo el círculo
                    width:
                        200, // Asegura que la imagen ocupe todo el espacio disponible
                    height:
                        200, // Asegura que la imagen ocupe todo el espacio disponible
                  )
                : Image.asset(
                    'assets/images/crocodile.png',
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
