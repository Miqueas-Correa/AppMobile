import 'package:flutter/material.dart';
import 'package:appanimals/widgets/animals_drawer_menu/animal_details.dart';

class AnimalCard extends StatelessWidget {
  final String image;
  final String text;
  final String detailedImage;

  const AnimalCard({
    super.key,
    required this.image,
    required this.text,
    required this.detailedImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String description = "";
        String title = "";
        Color titleColor = Colors.white;
        String animalType = "";

        // Lógica para definir el título y la descripción del animal
        if (text == 'Gatos') {
          title = "Época Egipcia";
          description = 'Se cree que los egipcios comenzaron a domesticar gatos alrededor del 4.000 a.C. Los gatos fueron venerados por los egipcios debido a su habilidad para cazar roedores, que eran una amenaza para los alimentos almacenados. \nSe les asociaba con la diosa Bastet, quien representaba la protección, la fertilidad y la casa. Los gatos eran tan respetados que eran momificados y enterrados junto a sus dueños en tumbas reales.';
        } else if (text == 'Perros') {
          title = "Época Prehistórica";
          description = 'Los perros domesticados descienden de los lobos, su domesticación comenzó hace 20.000-40.000 años. \nA lo largo de los milenios, los lobos más dóciles y amigables se fueron uniendo a las tribus humanas, desarrollándose gradualmente en los perros que conocemos hoy. \nLos perros desempeñaron un papel crucial en la caza, el pastoreo y la protección, y se fueron adaptando a las necesidades humanas, evolucionando en una gran variedad de razas.';
          animalType = "perros";
        } else if (text == 'Peces') {
          title = "Época Prehistórica";
          description = 'Los peces son uno de los grupos de animales más antiguos que existen. \nLos primeros vertebrados acuáticos aparecieron hace más de 500 millones de años, durante el período Cámbrico. \nEn esa época, los peces eran simples y sin mandíbulas, pero con el tiempo evolucionaron, dando lugar a formas más complejas, como los peces con mandíbulas y, eventualmente, a los peces cartilaginosos (como los tiburones) y los peces óseos que dominan los océanos y ríos actuales.';
          animalType = "peces";
        } else if (text == 'Cocodrilos') {
          title = "Época Prehistórica";
          description = 'Los cocodrilos han existido desde hace más de 200 millones de años, y pertenecen al grupo de los arcosaurios. \nEn la prehistoria, vivían en ambientes acuáticos similares a los actuales, pero en un entorno con especies de animales y plantas que ya no existen. \nHoy en día, los cocodrilos siguen siendo considerados "fósiles vivientes", ya que su anatomía es prácticamente la misma que hace millones de años.';
          animalType = "cocodrilos";
        }

        // Navegar a la pantalla AnimalDetails
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimalDetails(
              imagePath: detailedImage,
              text: description,
              title: title,
              titleColor: titleColor,
              animalType: animalType, 
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
                image,
                height: 120,
                width: 120,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
                decoration: TextDecoration.none
              ),
            )
          ],
        ),
      ), 
    );  
  }
}
