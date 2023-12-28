// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

ProductBestModels ProductBestModelsFromJson(String str) =>
    ProductBestModels.fromJson(json.decode(str));

String ProductBestModelsToJson(ProductBestModels data) => json.encode(data.toJson());

class ProductBestModels {
  String id;
  String name;
  String image;
  int gia;
  String desc;
  bool fav;
 // int query;
  int sl;
  String categoryId;


  ProductBestModels({
    required this.id,
    required this.name,
    required this.image,
    required this.gia,
    required this.desc,
    required this.fav,
   // required this.query,
    required this.sl,
    required this.categoryId,
  });

  factory ProductBestModels.fromJson(Map<String, dynamic> json) => ProductBestModels(
    id: json["id"].toString(),
    name: json["name"],
    image: json["image"],
    gia:json["gia"],
    desc: json["desc"],
    fav: false,
   //query: json["query"],
    sl: json["sl"],
    categoryId: json["categoryId"]??"",

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "gia": gia,
    "desc": desc,
    "fav": fav,
  //  "query": query,
    "categoryId":categoryId,
    "sl":sl,
  };
  ProductBestModels copyWith(
      {
        String? name,
        String?image,
        String? categoryId,
        String? id,
        String? desc,
        String? gia,
        String? soluong,
        String? sl,

      })=>
      ProductBestModels(
        id: id?? this.id,
        categoryId: categoryId??this.categoryId,
        gia: gia !=null ? int.parse(gia) : this.gia,
        desc: desc??this.desc,
        name: name?? this.name,
        image: image?? this.image,
        fav: false,
        sl: sl !=null ? int.parse(sl) : this.sl,
    //    query: 1,

      );


}
