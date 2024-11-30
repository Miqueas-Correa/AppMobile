import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatsDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> cat;

  const CatsDetailsScreen({super.key, required this.cat});

  @override
  _CatsDetailsScreenState createState() => _CatsDetailsScreenState();
}

class _CatsDetailsScreenState extends State<CatsDetailsScreen> {
  late TextEditingController _nameController;
  late bool _isFavorite;
  late bool _isHunter;
  late double _rating;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.cat['name'] ?? '');
    _isFavorite = widget.cat['isFavorite'] ?? false;
    _isHunter = widget.cat['isHunter'] ?? false;
    _rating = widget.cat['rating'] ?? 0.0;
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavorite = prefs.getBool('${widget.cat['id']}_favorite') ?? _isFavorite;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${widget.cat['id']}_favorite', _isFavorite);
  }

  void _toggleFavorite(bool value) {
    setState(() {
      _isFavorite = value;
    });
    _savePreferences();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil del pez'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: _buildForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.green[700],
      width: double.infinity,
      height: 200,
      child: Center(
        child: CircleAvatar(
          radius: 60,
          backgroundImage: widget.cat['avatar'] != null
              ? NetworkImage(widget.cat['avatar'])
              : const AssetImage('assets/images/default_cat.jpg')
                  as ImageProvider,
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile.adaptive(
          title: const Text('Favorito'),
          value: _isFavorite,
          onChanged: _toggleFavorite,
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _nameController,
          readOnly: true, // El usuario no puede editar
          decoration: const InputDecoration(
            labelText: 'Nombre',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        _buildReadOnlyField('Especie', widget.cat['species'] ?? 'No especificada'),
        _buildReadOnlyField('Color', widget.cat['color'] ?? 'No especificado'),
        SwitchListTile.adaptive(
          title: const Text('Cazador'),
          value: _isHunter,
          onChanged: (value) {
            setState(() {
              _isHunter = value;
            });
          },
        ),
        const SizedBox(height: 20),
        _buildStarRating(),
      ],
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _rating ? Icons.star : Icons.star_border,
                color: Colors.green,
              ),
              onPressed: () {
                setState(() {
                  _rating = index + 1.0;
                });
              },
            );
          }),
        ),
        Text('Calificación: ${_rating.toStringAsFixed(1)}'),
      ],
    );
  }
}
