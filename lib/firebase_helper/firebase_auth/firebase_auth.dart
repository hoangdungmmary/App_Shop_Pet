import 'package:app_pet_shop/constants/constants.dart';
import 'package:app_pet_shop/models/user_model/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseAuthHelper{
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   Stream<User?> get getAuthChange=> _auth.authStateChanges();

   Future<bool> login(
       String email, String password, BuildContext context) async{
      try{
        showLoaderDialog(context);
         await _auth.signInWithEmailAndPassword(email: email, password: password);
          Navigator.of(context).pop();
          return true;
      }on FirebaseAuthException catch(error){
        Navigator.of(context).pop();
        showMessage(error.code.toString());
          return false;
      }
   }

  Future<bool> signup(
    String name ,String email, String password,String phone,String Diachi, BuildContext context) async{
    try{
      showLoaderDialog(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
          email: email, password: password);
     UserModels userModels = UserModels(
         id: userCredential.user!.uid, name: name,phone:phone,image: null,
         email: email, Diachi: Diachi);
     _firestore.collection("users").doc(userModels.id).set(userModels.toJson());
      Navigator.of(context).pop();
      return true;
    }on FirebaseAuthException catch(error){
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }
  void singOut() async{
     await _auth.signOut();

  }

  Future<bool> changePassword(
      String password,BuildContext context) async{
    try{
      showLoaderDialog(context);
      _auth.currentUser!.updatePassword(password);
      Navigator.of(context,rootNavigator: true).pop();
      showMessage("Passwword change");
      Navigator.of(context).pop();
      return true;
    }on FirebaseAuthException catch(error){
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }
}