// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

PetModels PetModelsFromJson(String str) =>
    PetModels.fromJson(json.decode(str));

String PetToJson(PetModels data) => json.encode(data.toJson());

class PetModels {
  String id;
  String name;
  String image;
  int age;
  String type;
  String sex;
  String desc;
  int cannang;
 // String userId;


  PetModels({
    required this.id,
    required this.name,
    required this.image,
    required this.age,
    required this.desc,
    required this.cannang,
  //  required this.userId,
    required this.type,
    required this.sex,

  });

  factory PetModels.fromJson(Map<String, dynamic> json) => PetModels(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    age: json["age"],
    desc: json["desc"],
    cannang: json["cannang"],
  //  userId: json["userId"],
    type: json["type"],
    sex: json["sex"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "age": age,
    "desc": desc,
    "cannang": cannang,
    //"userId": userId,
    "type": type,
    "sex": sex,
  };

  @override
  PetModels copyWith(
      {
        String? age,
        String?cannang,
      //  String? userId,
        String?name,
        String?desc,
        String?image,
        String?type,
        String?sex
      })=>
      PetModels(
        id: id,
        name: name ?? this.name,
        image: image?? this.image,
        age: age !=null ? int.parse(age) : this.age,
        cannang: cannang !=null ? int.parse(cannang) : this.cannang,
        desc: desc ?? this.desc,
      //  userId: userId??this.userId,
        type: type ?? this.type,
        sex: sex??this.sex,
      );
}
