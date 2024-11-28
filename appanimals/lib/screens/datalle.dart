import 'package:appanimals/service/api_service.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String category; // Categoría (e.g., 'dogs')
  final String id; // ID (e.g., '1')

  const DetailScreen({super.key, required this.category, required this.id});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late ApiService apiService;
  Map<String, dynamic>? data; // Almacena los datos obtenidos
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(
        baseUrl: 'https://api-express-g17-tup-utn.onrender.com/api/v1');
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await apiService.fetchDataByCategoryAndId(widget.category, widget.id);
      setState(() {
        data = response; // Guarda el campo "data" de la respuesta
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : data != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nombre: ${data!['nombre']}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Raza: ${data!['raza']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Fecha de nacimiento: ${data!['fecha_nacimiento']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'ID: ${data!['id']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text(
                      'No se encontraron datos para esta categoría e ID.')),
    );
  }
}
