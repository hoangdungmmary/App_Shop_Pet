import 'dart:io';

import 'package:app_pet_shop/constants/constants.dart';
import 'package:app_pet_shop/firebase_helper/firebase_storage/firebase_storage.dart';
import 'package:app_pet_shop/firebase_helper/frebase_firestore/firebase_firestore.dart';
import 'package:app_pet_shop/models/comment/commentModels.dart';
import 'package:app_pet_shop/models/order_servce_models/order_service_models.dart';
import 'package:app_pet_shop/models/pet_Models/pet_Models.dart';
import 'package:app_pet_shop/models/product_models/product_models.dart';
import 'package:app_pet_shop/models/traningpet/traning_models.dart';
import 'package:app_pet_shop/models/user_model/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/theme_colors.dart';
import '../models/Service_Models/Service_Models.dart';

class AppProvider with ChangeNotifier{
  /// cart work
  // PetModels? _petList;
  // PetModels get getPetModels => _petList!;
  ProductModels? _productModels;
  ProductModels get getProductModels => _productModels!;
  final List<ProductModels> _cartProductList =[];
  final List<ProductModels> _buyProductList =[];
  final List<ServiceModels> _cartServiceList  =[];
  final List<ServiceModels> _buyServiceList =[];
 List<PetModels> _petList =[];
  List<CommentModels> _getComments =[];
  final List<OrderServiceModels> _oderServiceList =[];
  UserModels? _userModels;
  UserModels get getUserfomation => _userModels!;
  void addCartProduct(ProductModels productModels){
    _cartProductList.add(productModels);
    notifyListeners();
  }

  void removeCartProduct(ProductModels productModels){
    _cartProductList.remove(productModels);
    notifyListeners();
  }

 List<ProductModels> get getCartProductList =>_cartProductList;

  //Favourtite

  final List<ProductModels> _favouriteProductList =[];
  void addfavouriteProduct(ProductModels productModels){
    _favouriteProductList.add(productModels);
    notifyListeners();
  }

  void removefavouriteProduct(ProductModels productModels){
    _favouriteProductList.remove(productModels);
    notifyListeners();
  }

  List<ProductModels> get getfavouriteProductList =>_favouriteProductList;

  // favourtite service
  final List<ServiceModels> _favouriteServiceList =[];
  void addfavouriteService(ServiceModels serviceModels){
    _favouriteServiceList.add(serviceModels);
    notifyListeners();
  }

  void removefavouriteService(ServiceModels serviceModels){
    _favouriteServiceList.remove(serviceModels);
    notifyListeners();
  }

  List<ServiceModels> get getfavouriteServiceList =>_favouriteServiceList;

  //user Information
  void getUserInfoFirebase () async{
    _userModels = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }
  void updateUserInfoFirebase(
      BuildContext context, UserModels userModels, File? file) async {
    showLoaderDialog(context);
      if(file == null){
        showLoaderDialog(context);
        _userModels = userModels;
        await FirebaseFirestore.instance.collection("users")
            .doc(_userModels!.id)
            .set(_userModels!.toJson());

        Navigator.of(context,rootNavigator: true).pop();
        Navigator.of(context).pop();
      }else{
        showLoaderDialog(context);
        String imageUrl =
        await FirebaseStorageHelper.instance.uploadUserImage(file);
        _userModels = userModels.copyWith(image:imageUrl);
        await FirebaseFirestore.instance.collection("users")
            .doc(_userModels!.id)
            .set(_userModels!.toJson());
        Navigator.of(context,rootNavigator: true).pop();
        Navigator.of(context).pop();
      }
    showMessage("Cập nhật thành công");
    notifyListeners();

  }

  // Tính giá tiền
double totalPrice(){
    double totalPrice = 0.0;
    for(var element in _cartProductList){
      totalPrice += element.gia * element.query!;
    }
    return totalPrice;
}

  void updateQuery (ProductModels productModels ,int query){
    int index = _cartProductList.indexOf(productModels);
    _cartProductList[index].query = query;
    notifyListeners();
  }


  void updatetrongluong (ServiceModels serviceModels ,int trongluong){
    int index = _cartServiceList.indexOf(serviceModels);
    _cartServiceList[index].trongluong = trongluong;
    notifyListeners();
  }

  // mua sản phẩm

  void addBuyProduct(ProductModels model){
    _buyProductList.add(model);
    notifyListeners();
  }
  void addBuyProductCartList(){
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }
  void clearCart(){
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct(){
    _buyProductList.clear();
    notifyListeners();
  }
 List<ProductModels> get getBuyProductList =>_buyProductList;

  // dat servce

  void addBuyService(ServiceModels model){
    _buyServiceList.add(model);
    notifyListeners();
  }
  void addBuyServiceCartList(){
    _buyServiceList.addAll(_cartServiceList);
    notifyListeners();
  }
  void clearCartService(){
    _buyServiceList.clear();
    notifyListeners();
  }

  void clearBuyService(){
    _buyServiceList.clear();
    notifyListeners();
  }
  List<ServiceModels> get getBuyServiceList =>_buyServiceList;

  // void getPetList() async{
  //   _petList = await FirebaseFirestoreHelper.instance.getPet(in);
  //   notifyListeners();
  // }
  List<PetModels> get getList => _petList;

  Future<void> deletePetFromFirebase (
      PetModels petModels) async{

    notifyListeners();
    String value =await FirebaseFirestoreHelper.instance
        .detelePet(petModels.id);
    if(value == "Xóa Thành công"){
      _petList.remove(petModels);
      showMessage("Xóa Thành công");
    }

    notifyListeners();
  }
  void updatePetList(int index,PetModels petModels) async{
    await FirebaseFirestoreHelper.instance.updateSinglePet(petModels);
    // int index = _userList.indexOf(userModels);
    _petList[index] = petModels;
    notifyListeners();
  }
  void addPet(
      File image,
      String name,
      String cannang,
      String age,
      String desc,
      String type,
      String sex,
      ) async{
    PetModels petModels =
    await FirebaseFirestoreHelper.instance
        .addSinglePet(image, name, age, type, desc, cannang, sex);
    _petList.add(petModels);
    notifyListeners();
  }
  //bình luận
  List<CommentModels> get getComments => _getComments;
  void getComment (String productId ) async{
    _getComments = await FirebaseFirestoreHelper.instance.getComments(productId);
    notifyListeners();
  }
  void addcmt(
      String text,
      ) async{
    CommentModels commentModels =
    await FirebaseFirestoreHelper.instance
        .addComment(text);
    _getComments.add(commentModels);
    notifyListeners();
  }

  // tranning
  // List<TranningModels> _tranningList =[];
  // Future<void> getTranningListFun () async{
  //   _tranningList =await FirebaseFirestoreHelper.instance.getTranning();
  // }
  // List<TranningModels> get getTranningList => _tranningList;
}