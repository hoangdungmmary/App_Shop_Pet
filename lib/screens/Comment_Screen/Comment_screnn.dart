
import 'package:app_pet_shop/models/comment/commentModels.dart';
import 'package:app_pet_shop/models/pet_Models/pet_Models.dart';
import 'package:app_pet_shop/models/user_model/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/routes.dart';
import '../../../firebase_helper/frebase_firestore/firebase_firestore.dart';
import '../../../models/product_models/product_models.dart';
import '../../../provider/app_provider.dart';

class CommentsView extends StatefulWidget{
  const CommentsView({
    super.key,
     required this.index, required this.commentModels,
  });
  final CommentModels commentModels;
  final int index;
  //final UserModels userModel;

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView > {
  List<CommentModels> commentsList =[];

  bool isLoading = false;
  void getCommentsList() async{
    setState(() {
      isLoading = true;
    });
    commentsList =  await FirebaseFirestoreHelper.instance.getComments(widget.commentModels.cmtId);
    setState(() {
      isLoading = false;
    });
  }

  void initState() {
    getCommentsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return StreamBuilder<List<CommentModels>>(
     // stream: FirebaseFirestore.instance.getC,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CommentModels> comments = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: comments.map((comment) {
              return Column(
                children: [
                  Text(comment.text),
                  SizedBox(height: 10,),
                  Text(comment.ngaycmt)
                ],

              );
            }).toList(),
          );
        } else {
          return CircularProgressIndicator(); // Loading indicator
        }
      },
    );
  }
}
