// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import  'dart:convert';

import '../product_models/product_models.dart';
class CommentModels {
  String cmtId;
  String text;
  String userId;
  String ngaycmt;
  String productId;



  CommentModels({
    required this.cmtId,
    required this.productId,
    required this.text,
    required this.userId,
    required this.ngaycmt,
  });

  factory CommentModels.fromJson(Map<String, dynamic> json){
    return CommentModels(
      cmtId: json["cmtId"],
      userId: json["userId"],
      text: json["text"],
      ngaycmt: json["ngaycmt"],
      productId: json["productId"],

    );
  }
  Map<String, dynamic> toJson() => {
    "cmtId": cmtId,
    "userId": userId,
    "text": text,
    "ngaycmt": ngaycmt,
    "productId": productId,
  };


}
