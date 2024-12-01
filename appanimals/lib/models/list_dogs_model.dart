import 'dart:convert';
import 'package:appanimals/models/dogs_model.dart';

List<DogsModel> dogsFromJson(String str) =>
    List<DogsModel>.from(json.decode(str).map((x) => DogsModel.fromJson(x)));

String dogsToJson(List<DogsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
