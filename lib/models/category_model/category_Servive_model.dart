// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

CategoryServiceModels categoryServiceModelsFromJson(String str) =>
    CategoryServiceModels.fromJson(json.decode(str));

String categoryServiceModelsToJson(CategoryServiceModels data) => json.encode(data.toJson());

class CategoryServiceModels {
  String id;
  String name;
  String image;


  CategoryServiceModels({
    required this.id,
    required this.name,
    required this.image,

  });

  factory CategoryServiceModels.fromJson(Map<String, dynamic> json) => CategoryServiceModels(
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
