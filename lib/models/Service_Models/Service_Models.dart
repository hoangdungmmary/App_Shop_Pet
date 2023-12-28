// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

ServiceModels ServiceModelsFromJson(String str) =>
    ServiceModels.fromJson(json.decode(str));

String ServiceModelsToJson(ServiceModels data) => json.encode(data.toJson());

class ServiceModels {
  String id;
  String name;
  String image;
  int gia;
  String desc;
  bool fav;
  String type;
  int trongluong;



  ServiceModels({
    required this.id,
    required this.name,
    required this.image,
    required this.gia,
    required this.desc,
    required this.fav,
    required this.type,
    required this.trongluong,
  });

  factory ServiceModels.fromJson(Map<String, dynamic> json) => ServiceModels(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    gia: json["gia"],
    desc: json["desc"],
    type: json["type"],
    trongluong: json["trongluong"],
    fav: false,


  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "trongluong":trongluong,
    "gia": gia,
    "desc": desc,
    "fav": fav,
    "type":type,
  };

  @override
  ServiceModels copyWith(
      {
        int? trongluong,
      })=>
      ServiceModels(
          id: id,
          name: name,
          image: image,
          gia: gia,
          desc: desc,
          fav: fav,
          type: type,
          trongluong: trongluong ?? this.trongluong
      );
}
