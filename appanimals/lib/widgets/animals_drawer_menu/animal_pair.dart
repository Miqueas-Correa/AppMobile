import 'package:flutter/material.dart';
import 'package:appanimals/widgets/widgets.dart';

class AnimalPair extends StatelessWidget {
  final String image1;
  final String text1;
  final String detailedImage1;
  final String image2;
  final String text2;
  final String detailedImage2;

  const AnimalPair({
    super.key,
    required this.image1,
    required this.text1,
    required this.detailedImage1,
    required this.image2,
    required this.text2,
    required this.detailedImage2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AnimalCard(
            image: image1,
            text: text1,
            detailedImage: detailedImage1,
          ),
          AnimalCard(
            image: image2,
            text: text2,
            detailedImage: detailedImage2,
          ),
        ],
      ),
    );
  }
}
