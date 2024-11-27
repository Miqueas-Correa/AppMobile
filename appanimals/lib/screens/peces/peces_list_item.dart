import 'package:flutter/material.dart';

class PecesListItem extends StatelessWidget {
  const PecesListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Obtiene los argumentos pasados
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // Accede a cada argumento con su clave
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil del pez'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderProfileCustomItem(
              size: size,
              avatar: args['avatar'],
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

class BodyProfileCustomItem extends StatelessWidget {
  final bool darkMode = false;
  final Map<String, dynamic> args;

  const BodyProfileCustomItem({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    // final temaProvider = Provider.of<ThemeProvider>(context, listen: false);
    // print(Preferences.darkmode);
    
    return Column(
      children: [
        SwitchListTile.adaptive(
          title: const Text('Favorito'),
          value: args['favorite'],
          onChanged: (value) {},
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
            onChanged: (value) {},
            style: const TextStyle(fontSize: 18),
            initialValue: args['especie'] ?? '',
            decoration: decorationInput(
                label: 'Especie:', helperText: 'Ingrese el nombre de la especie del pez')),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
            onChanged: (value) {},
            style: const TextStyle(fontSize: 18),
            initialValue: args['name'] ?? '',
            keyboardType: TextInputType.text,
            decoration: decorationInput(label: 'Nombre:', helperText: "Ingrese el nombre del pez")),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
            onChanged: (value) {},
            style: const TextStyle(fontSize: 18),
            initialValue: args['color'] ?? '',
            keyboardType: TextInputType.text,
            decoration: decorationInput(label: 'Color: ')),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
            onChanged: (value) {},
            style: const TextStyle(fontSize: 18),
            initialValue: args['id'] ?? '',
            keyboardType: TextInputType.text,
            decoration: decorationInput(label: 'N° de ID:', helperText: "FIJATE PORQUE NO SE MUESTRA")),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
            onChanged: (value) {},
            style: const TextStyle(fontSize: 18),
            initialValue: args['stars'].toString(),
            keyboardType: TextInputType.text,
            decoration: decorationInput(label: 'Stars')),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  InputDecoration decorationInput(
      {IconData? icon, String? hintText, String? helperText, String? label}) {
    return InputDecoration(
      fillColor: Colors.black,
      label: Text(label ?? ''),
      hintText: hintText,
      helperText: helperText,
      helperStyle: const TextStyle(fontSize: 16),
      prefixIcon: (icon != null) ? Icon(icon) : null,
    );
  }
}

class HeaderProfileCustomItem extends StatelessWidget {
  final Size size;
  final String? avatar;

  const HeaderProfileCustomItem({
    super.key,
    this.avatar,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      color:  const Color.fromARGB(216, 21, 100, 21),
      child: Center(
        child: CircleAvatar(
          radius: 100,
          child: avatar != ""
              ? Image.asset('assets/avatars_peces/$avatar.png')
              : Image.asset('assets/images/fish.png'),
        ),
      ),
    );
  }
}