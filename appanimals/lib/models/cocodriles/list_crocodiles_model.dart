import 'dart:convert';
import 'package:appanimals/models/cocodriles/crocodiles_model.dart';

List<Crocodile> crocodilesFromJson(String str) =>
    List<Crocodile>.from(json.decode(str).map((x) => Crocodile.fromJson(x)));

String crocodilesToJson(List<Crocodile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
