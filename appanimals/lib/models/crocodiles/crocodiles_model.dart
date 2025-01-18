class Crocodile {
  final String id;
  final String name;
  final String color;
  final String habitat;
  final String avatar;
  double stars; // Calificación de estrellas
  bool isFavorite; // Nuevo campo 'favorite' de tipo bool


  Crocodile({
    required this.id,
    required this.name,
    required this.color,
    required this.habitat,
    required this.avatar,
    required this.stars,
    this.isFavorite = false, // Valor por defecto 'false'

  });
  
  factory Crocodile.fromJson(Map<String, dynamic> json) {
    return Crocodile(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      habitat: json['habitat'],
      avatar: json['avatar'],
      stars: (json['stars'] != null) ? json['stars'].toDouble() : 0.0, // Aseguramos que 'stars' nunca sea null
      isFavorite: json['favorite'] ?? false, // Asegúrate de que venga el valor de 'favorite' si existe
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'habitat': habitat,
      'avatar': avatar,
      'favorite': isFavorite,
    };
  }

  
}
