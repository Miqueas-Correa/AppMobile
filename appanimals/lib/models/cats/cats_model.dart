class Cat {
  final String id;
  final String nombre;
  final String raza;
  final String color;
  final String avatar;
  double estrella;
  bool favorito;

  Cat({
    required this.id,
    required this.nombre,
    required this.raza,
    required this.color,
    required this.avatar,
    required this.estrella,
    this.favorito = false,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['id'] ?? '', 
      nombre: json['nombre'] ?? '', 
      raza: json['raza'] ?? '',
      color: json['color'] ?? '',
      avatar: json['avatar'] ?? '', 
      estrella: (json['estrella'] != null) ? json['estrella'].toDouble() : 0.0,
      favorito: json['favorito'] ?? false, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'raza': raza,
      'color': color,
      'avatar': avatar,
      'estrella': estrella,
      'favorito': favorito,
    };
  }
}
