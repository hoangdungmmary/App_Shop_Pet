
import 'package:app_pet_shop/models/pet_Models/pet_Models.dart';
import 'package:app_pet_shop/models/user_model/user_models.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/routes.dart';
import '../../../firebase_helper/frebase_firestore/firebase_firestore.dart';
import '../../../models/product_models/product_models.dart';
import '../../../provider/app_provider.dart';
import '../edit_pet/edit_pet.dart';

class SinglePetView extends StatefulWidget{
  const SinglePetView({
    super.key,
    required this.singlePet, required this.index, 
  });
  final PetModels singlePet;
  final int index;
  //final UserModels userModel;

  @override
  State<SinglePetView> createState() => _SinglePetViewState();
}

class _SinglePetViewState extends State<SinglePetView > {
  List<PetModels> petList =[];

  bool isLoading = false;
  void getPetList() async{
    setState(() {
      isLoading = true;
    });
    petList =  await FirebaseFirestoreHelper.instance.getPet(widget.singlePet.id);
    setState(() {
      isLoading = false;
    });
  }

  void initState() {
    getPetList();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return  Card(
      color: Colors.white,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        //   alignment: Alignment.topRight,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Image.network(widget.singlePet.image,height: 100,width: 100,),
                  ),
                  const SizedBox(height:12),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(widget.singlePet.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),),
                  ),
                  Text(
                    "${widget.singlePet.age.toString()} Tuổi " , style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),),
                ],
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  IgnorePointer(
                    ignoring: isLoading,
                    child: GestureDetector(
                      onTap: () async{
                        setState(() {
                          isLoading = true;
                        });
                        await appProvider.deletePetFromFirebase(widget.singlePet);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading?Center(
                        child: CircularProgressIndicator(),)
                          :Icon(
                        Icons.delete,color: Colors.red ,),
                    ),
                  ),
                  SizedBox(width: 6),
                  GestureDetector(
                    onTap: (){
                      Routes.instance.push(
                          widget: EditPet(petModels: widget.singlePet, index: widget.index), context: context);
                    },
                    child: Icon(Icons.edit),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
