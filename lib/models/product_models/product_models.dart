// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

ProductModels ProductModelsFromJson(String str) =>
    ProductModels.fromJson(json.decode(str));

String ProductModelsToJson(ProductModels data) => json.encode(data.toJson());

class ProductModels {
  String id;
  String name;
  String image;
  int gia;
  String desc;
  bool fav;
  int query;
  int sl;
  String categoryId;


  ProductModels({
    required this.id,
    required this.name,
    required this.image,
    required this.gia,
    required this.desc,
    required this.fav,
     required this.query,
    required this.sl,
    required this.categoryId,
  });

  factory ProductModels.fromJson(Map<String, dynamic> json) => ProductModels(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    gia: json["gia"],
    desc: json["desc"],
    fav: false,
    query: json["query"],
    sl: json["sl"],
    categoryId: json["categoryId"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "gia": gia,
    "desc": desc,
    "fav": fav,
    "query": query,
    "sl": sl,
    "categoryId": categoryId,
  };

  @override
  ProductModels copyWith(
  {
    int? query,
    int?sl,
    String? categoryId,
})=>
      ProductModels(
          id: id,
          name: name,
          image: image,
          gia: gia,
          desc: desc,
          fav: fav,
          query: query ?? this.query,
          sl: sl ?? this.sl,
        categoryId: categoryId??this.categoryId,
      );
}
