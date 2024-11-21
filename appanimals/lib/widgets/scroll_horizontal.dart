import 'dart:async';
import 'package:flutter/material.dart';

class HorizontalScroll extends StatefulWidget {
  final List<String> imagePaths;

  const HorizontalScroll({super.key, required this.imagePaths});

  @override
  State<HorizontalScroll> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalScroll> {
  late final PageController _pageController;
  late final Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < widget.imagePaths.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 255, // Altura del contenedor
      width: double.infinity, // Ancho del contenedor
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.imagePaths.length,
        itemBuilder: (context, index) {
          return Center(
            // Centra la tarjeta en el contenedor
            child: SizedBox(
              width: 350, // Ancho específico de la tarjeta
              height: 350, // Altura específica de la tarjeta
              child: Card(
                color: Colors.green, // Color verde para la tarjeta
                elevation: 5, // Sombra
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                child: Column(
                  children: [
                    // Imagen en la tarjeta
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(
                            10), // Bordes redondeados superiores
                      ),
                      child: Image.asset(
                        widget.imagePaths[index],
                        width: 255, // Ancho de la imagen
                        height: 200, // Altura de la imagen
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Texto en la tarjeta
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '(NEW ${index + 1})',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
