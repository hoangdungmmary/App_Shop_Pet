
import 'package:app_pet_shop/models/pet_Models/pet_Models.dart';
import 'package:app_pet_shop/screens/pet_screen/add_pet/add_pet.dart';
import 'package:app_pet_shop/screens/pet_screen/widget/single_pet_Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../models/product_models/product_models.dart';
import '../../provider/app_provider.dart';


class PetView extends StatefulWidget {
  const PetView({Key? key}) : super(key: key);

  @override
  State<PetView> createState() => _PetViewState();
}

class _PetViewState extends State<PetView> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin Thú Cưng"),
        actions: [
          IconButton(onPressed: (){
            Routes.instance.push(widget: AddPet(), context: context);
          },
              icon:const Icon(Icons.add_circle))
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const Text("Thú cưng của bạn",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),),
                const SizedBox(height: 12,),
                GridView.builder(
                    padding: const EdgeInsets.all(12),
                    shrinkWrap: true,
                    itemCount: appProvider.getList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 20,
                        crossAxisCount: 2),
                    itemBuilder: (ctx,index){
                      PetModels  singlePet = appProvider.getList[index];
                      return SinglePetView(singlePet: singlePet ,index: index,);
                    }
                ),
              ],
            )
        ),
      ),
    );
  }
}
