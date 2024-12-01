import 'package:appanimals/service/animal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:appanimals/models/categories_model.dart';

class AnimalDetailScreen extends StatefulWidget {
  final Category animal;

  const AnimalDetailScreen({super.key, required this.animal});

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  final TextEditingController _idController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _animalData;
  bool _isFavorite = false;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _fetchAnimalData(String id) async {
    _animalData = await AnimalService.fetchAnimalData(
      category: widget.animal.title.toLowerCase(),
      id: id,
      showSnackBar: _showSnackBar,
      setLoading: (loading) => setState(() => _isLoading = loading),
    );
    setState(() {}); // Actualizar el estado para mostrar la tarjeta del animal
  }
  Widget _buildAnimalCard() {
    return AnimalService.buildAnimalCard(
      animalData: _animalData,
      category: widget.animal.title.toLowerCase(),
      isFavorite: _isFavorite,
      toggleFavorite: () => setState(() {
        _isFavorite = !_isFavorite;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.animal.title),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                widget.animal.imagePath,
                fit: BoxFit.contain, // ajusto la img
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingrese el ID del animal (1 a 50):',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _idController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ID',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    if (newValue.text.isEmpty) return newValue;
                    final int? value = int.tryParse(newValue.text);
                    if (value == null || value < 1 || value > 50) {
                      return oldValue;
                    }
                    return newValue;
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final id = _idController.text;
                if (id.isEmpty) {
                  _showSnackBar('Por favor ingrese un ID.');
                } else {
                  _fetchAnimalData(id);
                }
              },
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            if (_animalData != null) _buildAnimalCard(),
          ],
        ),
      ),
    );
  }
}
