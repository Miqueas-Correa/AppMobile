class Fishes {
  final String id;
  final String especie;
  final String nombre;
  final String color;


  Fishes({
    required this.especie,
    required this.nombre,
    required this.color,
    required this.id,
  });

  factory Fishes.fromJson(Map<String, dynamic> json) => Fishes(
        especie: json["especie"] ?? 'Especie no encontrada',
        nombre: json["nombre"] ?? 'Nombre desconocido',
        color: json["color"] ?? 'Color no econtrado',
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "especie": especie,
        "nombre": nombre, //no muestra -> dice nombre desconocido
        "olor": color,
        "id": id,
      };
}