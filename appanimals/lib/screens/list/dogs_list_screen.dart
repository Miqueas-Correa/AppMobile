import 'package:flutter/material.dart';

class DogsListScreen extends StatelessWidget {
  const DogsListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perros'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Perro $index'),
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => DogProfileScreen(dogId: index),
            //     ),
            //   );
            // },
          );
        },
      ),
    );
  }
}
