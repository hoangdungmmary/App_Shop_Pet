// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

UserModels userModelsFromJson(String str) =>
    UserModels.fromJson(json.decode(str));

String userModelsToJson(UserModels data) => json.encode(data.toJson());

class UserModels {
  String id;
  String name;
  String email;
  String ?phone;
  String ?Diachi;
  String? image;


  UserModels({
    required this.id,
    required this.name,
    this.image,
    required this.email,
   required this.phone,
    required this.Diachi,
  });

  factory UserModels.fromJson(Map<String, dynamic> json) => UserModels(
    id: json["id"],
    name: json["name"],
    image: json["image"],
     email: json["email"],
    Diachi: json["Diachi"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "phone":phone,
    "email": email,
    "Diachi": Diachi,
  };



  UserModels copyWith(
      {
        String? name,image,phone,Diachi
      })=>
      UserModels(
          id: id,
          email: email,
          name: name?? this.name,
          image: image?? this.image,
         phone: phone?? this.phone,
        Diachi: Diachi?? this.Diachi,
      );
}
