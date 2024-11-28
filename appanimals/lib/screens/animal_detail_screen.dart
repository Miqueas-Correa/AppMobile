// import 'package:appanimals/models/structs/crocodiles_struct.dart';
import 'package:appanimals/models/structs/dogs_struct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:appanimals/models/categories_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> _fetchAnimalData(String id) async {
    final url =
        'https://api-express-g17-tup-utn.onrender.com/api/v1/${widget.animal.title.toLowerCase()}/$id';
    setState(() {
      _isLoading = true;
      _animalData = null;
    });

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['msg'] == 'Ok' && decoded['data'] != null) {
          setState(() {
            _animalData = decoded['data'];
          });
        } else {
          _showSnackBar('No se encontraron datos para este ID.');
        }
      } else {
        _showSnackBar('Error al obtener datos. Código: ${response.statusCode}');
      }
    } catch (e) {
      _showSnackBar('Error en la conexión: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildAnimalCard() {
    if (_animalData == null) return const SizedBox.shrink();

    switch (widget.animal.title.toLowerCase()) {
      case 'dogs':
        return DogStruct(_animalData!, _isFavorite, () {
          setState(() {
            _isFavorite = !_isFavorite;
          });
        });
      case 'cats':
        // Aquí puedes agregar la estructura para cats
        return const Text('Estructura para Cats no implementada.');
      case 'crocodiles':
        // return CrocodileStruct(_animalData!, _isFavorite, () {
        //   setState(() {
        //     _isFavorite = !_isFavorite;
        //   });
        // });
      case 'fish':
        // Aquí puedes agregar la estructura para fish
        return const Text('Estructura para Fish no implementada.');
      default:
        return const Text('Categoría no soportada.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.animal.title),
        backgroundColor: Colors.green,
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
