class Cats {
  final String id;
  final String raza;
  final String nombre;
  final String color;
  bool favorite;
  double stars;

  Cats({
    required this.id,
    required this.raza,
    required this.nombre,
    required this.color,
    this.favorite = false,
    this.stars = 0.0,
  });

  factory Cats.fromJson(Map<String, dynamic> json) {
    return Cats(
      id: json['id']?.toString() ?? '',
      raza: json['raza']?.toString() ?? '',
      nombre: json['nombre']?.toString() ?? '',
      color: json['color']?.toString() ?? '',
      favorite: json['favorite'] == 'true' || json['favorite'] == true,
      stars: double.tryParse(json['stars']?.toString() ?? '0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'raza': raza,
    'nombre': nombre,
    'color': color,
    'favorite': favorite,
    'stars': stars,
  };
}
