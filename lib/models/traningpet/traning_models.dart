// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

TranningModels ctraningModelsFromJson(String str) =>
    TranningModels.fromJson(json.decode(str));

String traningModelsToJson(TranningModels data) => json.encode(data.toJson());

class TranningModels {
  String id;
  String name;
  String image;


  TranningModels({
    required this.id,
    required this.name,
    required this.image,

  });

  factory TranningModels.fromJson(Map<String, dynamic> json) => TranningModels(
    id: json["id"],
    name: json["name"],
    image: json["image"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,

  };
}
