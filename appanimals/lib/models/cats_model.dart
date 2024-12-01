class CatsModel {
  String? nombre;
  String? color;
  String? raza;
  String id;
  String? avatar;
  String? fechaNacimiento;
  String? cazador;
  double estrella = 0.0;
  bool favorito = false;

  CatsModel({
    required this.nombre,
    required this.color,
    required this.raza,
    required this.id,
    required this.fechaNacimiento,
    required this.cazador,
    this.avatar,
  });

  factory CatsModel.fromJson(Map<String, dynamic> json){
    return CatsModel(
      id: json['id'], 
      nombre: json['nombre'] as String?, 
      color: json['color'] as String?, 
      raza: json['raza'] as String?, 
      avatar: json['avatar'] as String?, 
      fechaNacimiento: json['fechaNacimiento'] as String?,
      cazador: json['cazador'] as String?, 
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'nombre': nombre,
      'color': color,
      'raza': raza,
      'avatar': avatar,
      'cazador': cazador,
      'fechaNacimiento' : fechaNacimiento,
      'estrella': estrella,
      'favorito': favorito,
    };
  }
}