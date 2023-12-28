// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:app_pet_shop/models/Service_Models/Service_Models.dart';

import '../product_models/product_models.dart';
class OrderServiceModels {
  String orderServiceId;
  String date;
  String time;
  String status;
  double totalPrice;
  String userId;
  List<ServiceModels> service;




  OrderServiceModels({
    required this.orderServiceId,
    required this.date,
   required this.totalPrice,
    required this.time,
  //  required this.comment,
    required this.status,
    required this.service,
    required this.userId,
 //   required this.trongluong,
  });

  factory OrderServiceModels.fromJson(Map<String, dynamic> json){
    List<dynamic> serviceMap =json["service"];
    return OrderServiceModels(
        orderServiceId: json["orderServiceId"],
        date: json["date"],
        totalPrice: json["totalPrice"],
        time: json["time"],
        status: json["status"],
        service: serviceMap.map((e)=>ServiceModels.fromJson(e)).toList(),
        userId: json["userId"]
    );
  }

}
