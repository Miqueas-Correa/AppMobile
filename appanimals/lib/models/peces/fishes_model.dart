class Fishes {
  final String id;
  final String nombre;
  final String color;
  final String especie;
  final String avatar;
  double stars;
  bool favorite;


  Fishes({
    required this.id,
    required this.nombre,
    required this.color,
    required this.especie,
    required this.avatar,
    required this.stars,
    this.favorite = false,
  });

  factory Fishes.fromJson(Map<String, dynamic> json) {
    return Fishes(
      id: json["id"],
      nombre: json["nombre"],
      color: json["color"],
      especie: json["especie"],
      avatar: json['avatar'],
      stars: (json['stars'] != null) ? json['stars'].toDouble() : 0.0,
      favorite: json['favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'color': color,
      'especie': especie,
      'avatar': avatar,
      'favorite': favorite,
    };
  }
}