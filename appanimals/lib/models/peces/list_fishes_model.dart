import 'dart:convert';
import 'package:appanimals/models/peces/fishes_model.dart';


List<Fishes> fishesFromJson(String str) =>
    List<Fishes>.from(json.decode(str).map((x) => Fishes.fromJson(x)));

String fishesToJson(List<Fishes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));