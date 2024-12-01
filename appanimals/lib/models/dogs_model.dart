class DogsModel {
  final String id;
  final String nombre;
  final String raza;
  final String fechaNacimiento;
  double stars; // Calificación de estrellas
  bool favorite; // Nuevo campo 'favorite' de tipo bool

  DogsModel({
    required this.id,
    required this.nombre,
    required this.raza,
    required this.fechaNacimiento,
    required this.stars,
    this.favorite = false, // Valor por defecto 'false'
  });

  factory DogsModel.fromJson(Map<String, dynamic> json) {
    return DogsModel(
      id: json['id'],
      nombre: json['nombre'],
      raza: json['raza'],
      fechaNacimiento: json['fecha_nacimiento'],
      stars: (json['stars'] != null) ? json['stars'].toDouble() : 0.0,
      favorite: json['favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id🐶: ': id,
      'Nombre: ': nombre,
      'Raza: ': raza,
      'Fecha de nacimiento: ': fechaNacimiento,
      'favorite: ': favorite,
    };
  }
}
