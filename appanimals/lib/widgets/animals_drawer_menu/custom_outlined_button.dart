import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            wordSpacing: 5,
          ),
          backgroundColor: const Color.fromARGB(255, 21, 100, 21), // Fondo blanco
          foregroundColor: Colors.white, // Texto verde
          side: const BorderSide(color: Color.fromARGB(255, 21, 100, 21)), // Borde verde
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
