// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

CategoryModels categoryModelsFromJson(String str) =>
    CategoryModels.fromJson(json.decode(str));

String categoryModelsToJson(CategoryModels data) => json.encode(data.toJson());

class CategoryModels {
  String id;
  String name;
  String image;


  CategoryModels({
    required this.id,
    required this.name,
    required this.image,

  });

  factory CategoryModels.fromJson(Map<String, dynamic> json) => CategoryModels(
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
