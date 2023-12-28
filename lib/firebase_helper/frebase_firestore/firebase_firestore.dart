
import 'dart:io';

import 'package:app_pet_shop/constants/constants.dart';
import 'package:app_pet_shop/models/Service_Models/Service_Models.dart';
import 'package:app_pet_shop/models/category_model/category_model.dart';
import 'package:app_pet_shop/models/order_servce_models/order_service_models.dart';
import 'package:app_pet_shop/models/product_models/product_models.dart';
import 'package:app_pet_shop/models/traningpet/traning_models.dart';
import 'package:app_pet_shop/models/user_model/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/category_model/category_Servive_model.dart';
import '../../models/comment/commentModels.dart';
import '../../models/order_models/order_models.dart';
import '../../models/pet_Models/pet_Models.dart';
import '../firebase_storage/firebase_storage.dart';


class FirebaseFirestoreHelper {

  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//theloa
  Future<List<CategoryModels>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore.collection("categories").get();
      List<CategoryModels> categoriesList = querySnapshot.docs
          .map((e) => CategoryModels.fromJson(e.data())).toList();

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }


  //tranning
  Future<List<TranningModels>> getTranning() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore.collection("traning").get();
      List<TranningModels> traningList = querySnapshot.docs
          .map((e) => TranningModels.fromJson(e.data())).toList();

      return traningList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }


// thể loại Service
  Future<List<CategoryServiceModels>> getServices() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore.collection("CategoriesService").get();
      List<CategoryServiceModels> serviceList = querySnapshot.docs
          .map((e) => CategoryServiceModels.fromJson(e.data())).toList();

      return serviceList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
//bestproduct
  Future<List<ProductModels>> getbestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore.collectionGroup("product").get();

      List<ProductModels> productModelList = querySnapshot.docs
          .map((e) => ProductModels.fromJson(e.data())).toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
  Future<List<ServiceModels>> getServiceProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore.collectionGroup("service").get();

      List<ServiceModels> serviceModelList = querySnapshot.docs
          .map((e) => ServiceModels.fromJson(e.data())).toList();

      return serviceModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
//Product

  Future<List<ProductModels>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore.collection("categories").doc(id).collection("product").get();

      List<ProductModels> productModelList = querySnapshot.docs
          .map((e) => ProductModels.fromJson(e.data())).toList();
      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  //Product Serivce

  Future<List<ServiceModels>> getServiceViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore.collection("CategoriesService").doc(id).collection("service").get();

      List<ServiceModels> serviceModelList = querySnapshot.docs
          .map((e) => ServiceModels.fromJson(e.data())).toList();
      return serviceModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  ///
  Future<UserModels> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
    await _firebaseFirestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
      
    return UserModels.fromJson(querySnapshot.data()!);
  }


  // upload oserproduct
  Future<bool> uploadOrderProductFirebase(
      List<ProductModels> list,BuildContext context,String payment ) async{
    try{
      showLoaderDialog(context);
      double totalPrice =0.0;
      for( var element in list){
        totalPrice += element.gia * element.query!;
      }
     DocumentReference documentReference =  _firebaseFirestore
         .collection("UsersOrders")
         .doc(FirebaseAuth.instance.currentUser!.uid)
         .collection("orders")
         .doc();
   DocumentReference admin = _firebaseFirestore.collection("orders").doc(documentReference.id);
   String uid = FirebaseAuth.instance.currentUser!.uid;
      admin.set({

       "product":list.map((e) => e.toJson()),
       "status": "Xử lý",
       "totalPrice": totalPrice,
        "userId":uid,
       "payment": payment,
        "orderId": admin.id,
        "ngayorder":DateFormat('dd/MM/yyyy').format(DateTime.now()),
     });
      documentReference.set({
        "product":list.map((e) => e.toJson()),
        "status": "Xử lý",
        "totalPrice": totalPrice,
        "userId":uid,
        "payment": payment,
        "orderId": documentReference.id,
        "ngayorder":DateFormat('dd/MM/yyyy').format(DateTime.now()),
      });
    Navigator.of(context,rootNavigator: true).pop();
    showMessage("Đặt hàng Thành công");
      return true;
    }
    catch(e){
      showMessage(e.toString());
      Navigator.of(context,rootNavigator: true).pop();
      return false;
    }
  }

  //upload order servce
  Future<bool> uploadOrderServiceFirebase(
      List<ServiceModels> list,BuildContext context,String date,String time) async{
    try{
      showLoaderDialog(context);
      double totalPrice =0.0;
      for( var element in list){
        totalPrice += element.gia * element.trongluong!;
      }
      DocumentReference documentReference =  _firebaseFirestore
          .collection("UsersOrdersService")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("ordersService")
          .doc();
      DocumentReference admin = _firebaseFirestore.collection("ordersService").doc(documentReference.id);
      String uid = FirebaseAuth.instance.currentUser!.uid;
      admin.set({
        "service":list.map((e) => e.toJson()),
        "status": "Xử lý",
        "totalPrice": totalPrice,
        "userId":uid,
        "date": date,
        "time": time,
       // "comment": comment,
        "orderServiceId": admin.id,
      });
      documentReference.set({
        "service":list.map((e) => e.toJson()),
        "status": "Xử lý",
        "totalPrice": totalPrice,
        "userId":uid,
        "date": date,
        "time": time,
       // "comment": comment,
        "orderServiceId": documentReference.id,
      });
      Navigator.of(context,rootNavigator: true).pop();
      showMessage("Đặt dịch vụ Thành công");
      return true;
    }
    catch(e){
      showMessage(e.toString());
      Navigator.of(context,rootNavigator: true).pop();
      return false;
    }
  }
  
  // get order ueser
Future<List<OrderModels>>  getUserOrder()async{
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
          .collection("UsersOrders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .get();
      List<OrderModels> orderList =
      querySnapshot.docs.map((element)=> OrderModels.fromJson(element.data())).toList();
      return orderList;
    }catch(e){
      showMessage(e.toString());
      return [];
    }
}

  // get order  Service ueser
  Future<List<OrderServiceModels>>  getUserOrderService()async{
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
          .collection("UsersOrdersService")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("ordersService")
          .get();
      List<OrderServiceModels> orderServiceList =
      querySnapshot.docs.map((element)=> OrderServiceModels.fromJson(element.data())).toList();
      return orderServiceList;
    }catch(e){
      showMessage(e.toString());
      return [];
    }
  }

  //update order product
  Future <void> updateOrder(OrderModels orderModels,String status) async{
    await _firebaseFirestore
        .collection("UsersOrders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("orders")
        .doc(orderModels.orderId)
    .update({
      "status" : status,
    }

    );
    await _firebaseFirestore
        .collection("orders")
        .doc(orderModels.orderId)
        .update({
      "status" : status,
    }

    );
  }
//


  //update order servce
  Future <void> updateOrderService(OrderServiceModels orderServiceModels,String status) async{
    await _firebaseFirestore
        .collection("UsersOrdersService")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("ordersService")
        .doc(orderServiceModels.orderServiceId)
        .update({
      "status" : status,
    }

    );
    await _firebaseFirestore
        .collection("ordersService")
        .doc(orderServiceModels.orderServiceId)
        .update({
      "status" : status,
    }

    );
  }


  Future <void> updatesl(ProductModels productModels,int sl) async{
    await _firebaseFirestore
        .collection("categories")
        .doc(productModels.categoryId)
        .collection("product")
        .doc(productModels.id)
        .update({
      "sl" : sl,
    }

    );

  }


  // get pet of user
  // Future<List<PetModels>> getPet()async{
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection("pet")
  //         .get();
  //     List<PetModels> petList  =
  //     querySnapshot.docs.map((element)=> PetModels.fromJson(element.data())).toList();
  //     return petList;
  // }

  Future<List<PetModels>> getPet(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore.collection("users").doc(id).collection("pet").get();

      List<PetModels> petList = querySnapshot.docs
          .map((e) => PetModels.fromJson(e.data())).toList();
      return petList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
  Future<PetModels> addSinglePet(File image, String name,String age,String type,String desc,String cannang,String sex) async{
    DocumentReference reference =_firebaseFirestore
        .collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("pet").doc();
    String imageUrl = await FirebaseStorageHelper.instance.uploadUserImagePet(reference.id, image);
    PetModels addPet =PetModels(
        id: reference.id,
        name: name,
        sex: sex,
        image: imageUrl,
        age: int.parse(age),
        cannang: int.parse(cannang),
        desc: desc,
        type:type,
       );
    await reference.set(addPet.toJson());
    return addPet;

  }

  Future<void> updateSinglePet(PetModels petModels) async{
    try{
      await _firebaseFirestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("pet")
          .doc(petModels.id)
          .update(petModels.toJson());

    }catch(e){

    }
  }

  Future<String> detelePet(String id) async{
    try{
      await _firebaseFirestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("pet")
          .doc(id)
          .delete();
      //await Future.delayed(Duration(seconds: 3),(){});
      return ("Xóa Thành công");
    }catch(e){
      return e.toString();
    }

  }

  // bình luận
  // lấy comment
   Future<List<CommentModels>> getComments(String productId) async{
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
          .collection("product")
          .doc(productId)
          .collection("comments")
          .get();
      List<CommentModels> commentsList =
      querySnapshot.docs.map((element)=> CommentModels.fromJson(element.data())).toList();
      return commentsList;
    }catch(e){
      showMessage(e.toString());
      return [];
    }
  }
  //add comments
  Future<CommentModels> addComment(String text) async{
    DocumentReference reference =_firebaseFirestore
        .collection("product").doc()
        .collection("comments").doc();
    DocumentReference comment = _firebaseFirestore.collection("comments").doc(reference.id);
    DocumentReference productid = _firebaseFirestore.collection("product").doc(reference.id);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CommentModels addcomment =CommentModels(
        cmtId: comment.id,
        productId: productid.id,
        text: text,
        userId: uid,
        ngaycmt: DateFormat('dd/MM/yyyy').format(DateTime.now()),
    );
    await reference.set(addcomment.toJson());
    return addcomment;

  }

}