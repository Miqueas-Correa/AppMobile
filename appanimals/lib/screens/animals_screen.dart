import 'package:flutter/material.dart';
import 'package:appanimals/widgets/animal_details.dart';

class AnimalScreen extends StatelessWidget {
  const AnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animales'),
        backgroundColor: const Color.fromARGB(255, 21, 100, 21),
        foregroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            NewPadding(
              image1:'assets/animals_screen/cat.jpg',
              text1: 'Gatos',
              detailedImage1: 'assets/animals_details/gato_detail.jpg',
              image2: 'assets/animals_screen/fish.png',
              text2: 'Peces',
              detailedImage2: 'assets/animals_details/peces_details.jpg'
            ),
            SizedBox(height: 10),
            NewPadding(
              image1: 'assets/animals_screen/dog.jpg',
              text1: 'Perros',
              detailedImage1: 'assets/animals_details/perro_details.jpg',
              image2: 'assets/animals_screen/cocodrile.png',
              text2: 'Cocodrilos',
              detailedImage2: 'assets/animals_details/cocodrilo_detail.jpg'
            ),
            SizedBox(height: 10),
            NewPadding(
              image1: 'assets/animals_screen/penguin.jpg',
              text1: 'Pingüinos',
              detailedImage1: 'assets/animals_screen/penguin.jpg',
              image2: 'assets/animals_screen/fox.webp',
              text2: 'Zorros',
              detailedImage2:'assets/animals_screen/fox.webp',
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class NewPadding extends StatelessWidget {
  final String image1;
  final String text1;
  final String detailedImage1;
  final String image2;
  final String text2;
  final String detailedImage2;

  // ignore: use_super_parameters
  const NewPadding({
    Key? key,
    required this.image1,
    required this.text1,
    required this.detailedImage1,
    required this.image2,
    required this.text2,
    required this.detailedImage2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              String description1 = "";
              String title = "";
              Color titleColor = Colors.white;

              // Lógica para definir el título y la descripción del primer animal
              if (text1 == 'Gatos') {
                title = "Época Egipcia";
                description1 = 'Los gatos domesticados tienen una larga relación con los humanos, especialmente en el antiguo Egipto. \nSe cree que los egipcios comenzaron a domesticar gatos alrededor del 4.000 a.C. Los gatos fueron venerados por los egipcios debido a su habilidad para cazar roedores, que eran una amenaza para los alimentos almacenados. \nSe les asociaba con la diosa Bastet, quien representaba la protección, la fertilidad y la casa. Los gatos eran tan respetados que eran momificados y enterrados junto a sus dueños en tumbas reales.';
              } else if (text1 == 'Perros') {
                title = "Época Prehistórica";
                description1 = 'Los perros domesticados descienden de los lobos. La domesticación del perro comenzó hace entre 20.000 y 40.000 años, cuando los seres humanos comenzaron a formar alianzas con los lobos. \nA lo largo de los milenios, los lobos más dóciles y amigables se fueron uniendo a las tribus humanas, desarrollándose gradualmente en los perros que conocemos hoy. \nLos perros desempeñaron un papel crucial en la caza, el pastoreo y la protección, y se fueron adaptando a las necesidades humanas, evolucionando en una gran variedad de razas.';
              }
              
              // Navegar a la pantalla AnimalDetails
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimalDetails(
                    imagePath: detailedImage1,
                    text: description1,
                    title: title,  // Pasar título
                    titleColor: titleColor, // Pasar color del título
                  ),
                ),
              );
            },
            child: Container(
              width: 160,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Image.asset(
                      image1,
                      height: 120,
                      width: 120,
                    ),
                  ),
                  Text(
                    text1,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      decoration: TextDecoration.none
                    ),
                  )
                ],
              ),
            ),
          ),
          
          GestureDetector(
            onTap: () {
              String title2 = "";
              Color titleColor2 = Colors.white;
              String description2 = "";

              // Lógica para definir el título y la descripción del segundo animal
              if (text2 == 'Peces') {
                title2 = "Época Prehistórica";
                titleColor2 = Colors.white;
                description2 = 'Los peces son uno de los grupos de animales más antiguos que existen. \nLos primeros vertebrados acuáticos aparecieron hace más de 500 millones de años, durante el período Cámbrico. \nEn esa época, los peces eran simples y sin mandíbulas, pero con el tiempo evolucionaron, dando lugar a formas más complejas, como los peces con mandíbulas y, eventualmente, a los peces cartilaginosos (como los tiburones) y los peces óseos que dominan los océanos y ríos actuales.';
              } else if (text2 == 'Cocodrilos') {
                title2 = "Prehistoria y Evolución";
                titleColor2 = Colors.white;
                description2 = 'Los cocodrilos han existido desde hace más de 200 millones de años, desde la época de los dinosaurios. \nEstos reptiles pertenecen a un grupo conocido como los arcosaurios, que también incluye a los dinosaurios y a las aves modernas. Aunque los cocodrilos han experimentado cambios a lo largo de su historia, su forma básica ha permanecido bastante constante. \nEn la prehistoria, vivían en ambientes acuáticos similares a los actuales, pero en un entorno con especies de animales y plantas que ya no existen. \nHoy en día, los cocodrilos siguen siendo considerados "fósiles vivientes", ya que su anatomía es prácticamente la misma que hace millones de años.';
              }

              // Navegar a la pantalla AnimalDetails
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimalDetails(
                    imagePath: detailedImage2,
                    text: description2,
                    title: title2,  // Pasar título
                    titleColor: titleColor2, // Pasar color del título
                  ),
                ),
              );
            },
            child: Container(
              width: 160,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Image.asset(
                      image2,
                      height: 120,
                      width: 120,
                    ),
                  ),
                  Text(
                    text2,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      decoration: TextDecoration.none
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
