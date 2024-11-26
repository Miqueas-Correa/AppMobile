import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:appanimals/models/categories_model.dart';

class AnimalDetailScreen extends StatelessWidget { // -> patanlla no tiene estado mutable, se reconstruye cd vez q cambia su config
  final Category animal; // declaro una var de tipo category para recinbir el animal a mostrt
  AnimalDetailScreen({super.key, required this.animal}); // constructor

  final TextEditingController _idController = TextEditingController(); // controlador pa manejar el text de campo de entreda id

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(animal.title),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset( // muesttro la img q reprenseta al animal
                animal.imagePath,
                width: MediaQuery.of(context).size.width * 0.7, 
                height: MediaQuery.of(context).size.height * 0.5,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingrese el ID del animal (1 a 50):',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _idController, // asocio el contralador del campo de text para obt el valor
                keyboardType: TextInputType.number, // solo numeros a ingresar
                decoration: const InputDecoration(
                  labelText: 'ID',
                  border: InputBorder.none, // elimino el borde predeterminado del campo de text
                  contentPadding: EdgeInsets.all(10),
                ),
                inputFormatters: [ // creo una lista de formateadores d entrada pa validar el text ingresado
                  FilteringTextInputFormatter.digitsOnly, // solo munn
                  TextInputFormatter.withFunction((viejoValor, nuevoValor) // funcion pa valiadar el valor ingresado
                  {
                    if(nuevoValor.text.isEmpty){ // si esta vacio no hay cambios
                      return nuevoValor;
                    }
                    final int? value = int.tryParse(nuevoValor.text);// intenfo convertir el texto a num
                    if (value == null || value < 1 || value > 50) { // si el num no es valido fuera de del rango 1-50
                      return viejoValor; // retorno el calor ant si el num no es valido
                    }
                    return nuevoValor; // si esta adnetro del rango, perimito el nuevo valor
                  })
                ],
              ),
            ),
            const SizedBox(height: 20), // espacio entre el camp de text y boton
            ElevatedButton(
              onPressed: (){
                String id = _idController.text; //obt el text ingresadp del controlador el id
                if (id.isEmpty){ 
                  ScaffoldMessenger.of(context).showSnackBar( // msj de advertencia
                    const SnackBar(content: Text('Por favor ingrese un ID:')),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Buscando el id: $id')),
                  );
                }
              }, 
              child: const Text('Buscar', selectionColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}