// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import '../product_models/product_models.dart';
class OrderModels {
  String orderId;
  String payment;
  String status;
  double totalPrice;
  String userId;
  String ngayorder;
  List<ProductModels> products;



  OrderModels({
    required this.orderId,
    required this.payment,
    required this.totalPrice,
    required this.status,
    required this.products,
    required this.userId,
    required this.ngayorder
  });

  factory OrderModels.fromJson(Map<String, dynamic> json){
    List<dynamic> productMap =json["product"];
   return OrderModels(
     orderId: json["orderId"],
     userId: json["userId"],
     payment: json["payment"],
     totalPrice: json["totalPrice"],
     products: productMap.map((e)=>ProductModels.fromJson(e)).toList(),
     status: json["status"],
     ngayorder: json["ngayorder"],

   );
  }

}
