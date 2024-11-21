import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Pantalla principal que muestra las noticias
class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

// Estado de la pantalla, responsable de manejar los datos y el estado de carga
class _NewsScreenState extends State<NewsScreen> {
  // Lista que almacena las noticias obtenidas de la API
  final List<Map<String, dynamic>> _news = [];
  // Indica si los datos están siendo cargados
  bool _isLoading = true;
  // Número de página para la paginación de la API
  int _page = 1;

  @override
  void initState() {
    super.initState();
    // Llama a la función para obtener las noticias al iniciar la pantalla
    _fetchNews();
  }

  // Función que obtiene las noticias desde la API
  Future<void> _fetchNews() async {
    const String apiKey = '4a3e02f5c6a2485f907790cd2ee51bef'; // Clave de la API
    final url = Uri.parse(
        'https://newsapi.org/v2/everything?q=animals&page=$_page&apiKey=$apiKey');
    try {
      // Realiza una petición GET a la API
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON y extrae las noticias
        final data = jsonDecode(response.body);
        setState(() {
          // Agrega las nuevas noticias a la lista existente
          _news.addAll((data['articles'] as List).map((article) {
            return {
              'title': article['title'], // Título de la noticia
              'description':
                  article['description'], // Descripción de la noticia
              'image': article['urlToImage'] ?? '', // Imagen de la noticia
            };
          }).toList());
          _isLoading = false; // Finaliza el estado de carga
        });
      } else {
        throw Exception('Error fetching news: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Finaliza el estado de carga en caso de error
      });
      debugPrint('Error: $e'); // Imprime el error en la consola
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Noticias',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // Verifica si los datos están cargando
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Animación de carga
          : NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                // Detecta si el usuario ha llegado al final del scroll
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    !_isLoading) {
                  setState(() {
                    _page++; // Incrementa la página para cargar más datos
                    _isLoading = true;
                  });
                  _fetchNews(); // Llama nuevamente a la API
                }
                return true;
              },
              child: ListView.builder(
                itemCount:
                    _news.length + 1, // Incluye un widget extra para el loader
                itemBuilder: (context, index) {
                  // Verifica si es el último elemento (loader)
                  if (index == _news.length) {
                    return _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox(); // Espacio vacío si no se está cargando
                  }
                  final item = _news[index];
                  return GestureDetector(
                    onTap: () {
                      // Abre un cuadro de diálogo al tocar la tarjeta
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(item['title']), // Muestra el título
                          content:
                              Text(item['description'] ?? 'Sin descripción'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cerrar'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 15), // Margen alrededor de la tarjeta
                      elevation: 5, // Sombra de la tarjeta
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // Bordes redondeados
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Verifica si hay una imagen disponible
                          item['image'].isNotEmpty
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: Image.network(
                                    item['image'], // URL de la imagen
                                    fit: BoxFit
                                        .cover, // Ajusta la imagen al contenedor
                                    height: 300, // Altura de la imagen
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        const Icon(Icons
                                            .broken_image), // Muestra un ícono si hay error
                                  ),
                                )
                              : const Icon(Icons.image_not_supported,
                                  size:
                                      50), // Muestra un ícono si no hay imagen
                          Padding(
                            padding:
                                const EdgeInsets.all(20.0), // Espaciado interno
                            child: Text(
                              item['title'] ??
                                  'Sin título', // Título de la noticia
                              style: const TextStyle(
                                fontSize: 20, // Tamaño del texto
                                fontWeight: FontWeight.bold, // Negrita
                              ),
                              textAlign: TextAlign.center, // Centrado del texto
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
