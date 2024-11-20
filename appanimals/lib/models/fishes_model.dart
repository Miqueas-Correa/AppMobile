class Fishes {
  String especie;
  String name;
  String color;
  String id;

  Fishes({
    required this.especie,
    required this.name,
    required this.color,
    required this.id,
  });

  factory Fishes.fromJson(Map<String, dynamic> json) => Fishes(
        especie: json["especie"], 
        name: json["name"],
        color: json["color"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "especie": especie,
        "name": name,
        "olor": color,
        "id": id,
      };
}