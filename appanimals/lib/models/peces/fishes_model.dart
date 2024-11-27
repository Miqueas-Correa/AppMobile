class Fishes {
  final String id;
  final String especie;
  final String nombre;
  final String color;
  final String avatar;
  double stars;
  bool favorite;


  Fishes({
    required this.id,
    required this.especie,
    required this.nombre,
    required this.color,
    required this.avatar,
    required this.stars,
    this.favorite = false,
  });

  factory Fishes.fromJson(Map<String, dynamic> json) {
    return Fishes(
      id: json["id"],
      especie: json["especie"],
      nombre: json["nombre"],
      color: json["color"],
      avatar: json['avatar'],
      stars: (json['stars'] != null) ? json['stars'].toDouble() : 0.0,
      favorite: json['favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'especie': especie,
      'nombre': nombre,
      'color': color,
      'avatar': avatar,
      'favorite': favorite,
    };
  }
}