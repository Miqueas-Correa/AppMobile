import 'dart:convert';
import 'package:appanimals/models/cats/cats_model.dart';


List<Cats> catsfishesFromJson(String str) =>
    List<Cats>.from(json.decode(str).map((x) => Cats.fromJson(x)));

String catsToJson(List<Cats> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));