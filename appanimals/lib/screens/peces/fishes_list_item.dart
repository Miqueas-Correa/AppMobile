import 'package:flutter/material.dart';
import 'package:appanimals/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FishesListItem extends StatelessWidget {
  final Map<String, dynamic> args;

  const FishesListItem({
    super.key, 
    required this.args
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil del pez'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
        elevation: 10,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderProfileCustomItem(
              size: size,
              avatarPath: args['avatar'],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BodyProfileCustomItem(args: args),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyProfileCustomItem extends StatefulWidget {
  final Map<String, dynamic> args;

  const BodyProfileCustomItem({
    super.key, 
    required this.args
  });

  @override
  _BodyProfileCustomItemState createState() => _BodyProfileCustomItemState();
}

class _BodyProfileCustomItemState extends State<BodyProfileCustomItem> {
  late bool favorito;

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final fishId = widget.args['id'];
    favorito = prefs.getBool(fishId) ?? false;  // Recuperar el estado del favorito
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(
            favorito ? Icons.favorite : Icons.favorite_border,
            color: favorito
                ? const Color.fromARGB(255, 21, 100, 21)
                : Colors.grey,
          ),
          onPressed: () async {
            // actualizar el estado del favorito en SharedPreferences o en el estado global
            final prefs = widget.args['id'];
            favorito = !favorito;
            final fishId = widget.args['id'];
            await prefs.setBool(fishId, favorito);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => Icon(
              index < widget.args['stars'] ? Icons.star : Icons.star_border,
              color: const Color.fromARGB(255, 21, 100, 21),
            ),
          ),
        ),
        const SizedBox(height: 30),
        // Información con título
        DataFishCard(title: 'Especie', data: widget.args['especie']),
        DataFishCard(title: 'Nombre', data: widget.args['nombre']),
        DataFishCard(title: 'Color', data: widget.args['color']),
      ],
    );
  }
}

class DataFishCard extends StatelessWidget {
  final String title;
  final String? data;

  const DataFishCard({
    super.key, 
    required this.title, 
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              data ?? 'Información no disponible',
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderProfileCustomItem extends StatelessWidget {
  final Size size;
  final String? avatarPath;

  const HeaderProfileCustomItem({
    super.key,
    required this.size,
    required this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      color: const Color.fromARGB(255, 21, 100, 21),
      child: Center(
        child: CircleAvatar(
          radius: 100,
          backgroundColor: Colors.white,
          child: avatarPath != ""
              ? Image.asset('assets/images/avatars_peces/$avatarPath.png')
              : Image.asset('assets/images/avatars_peces/avatar1.png'),
        ),
      ),
    );
  }
}
