
import 'dart:io';
import 'package:app_pet_shop/models/pet_Models/pet_Models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../provider/app_provider.dart';


class AddPet extends StatefulWidget {

  const AddPet({Key? key}) : super(key: key);

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {

  @override
  File? image;
  void takePicture() async{
    XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 40);
    if(value!= null){
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController cannang = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController sex = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Thêm thú cưng của bạn",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image ==null
              ?CupertinoButton(
            onPressed: (){
              takePicture();
            },
            child: const CircleAvatar(
              radius: 70,
              child:
              Icon(Icons.camera_alt),
            ),
          )
              :CupertinoButton(
            onPressed: (){
              takePicture();
            },
            child: CircleAvatar(
              radius: 70,
              backgroundImage: FileImage(image!),
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: name,
            decoration: const InputDecoration(
              hintText:"Tên thú cưng",
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: desc,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText:"Miêu tả sản phẩm",
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: age,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText:"Tuổi thú cưng",
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: cannang,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText:"Trọng lượng thú cưng:",
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: type,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText:"Loại thú cưng",
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: sex,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText:"Giống thú cưng",
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            child:const Text("Thêm thú cưng") ,
            onPressed: () async{
              if(image == null ||
                  name.text.isEmpty ||
                  desc.text.isEmpty ||
                  age.text.isEmpty  ||
                  sex.text.isEmpty  ||
                  type.text.isEmpty  ||
                  cannang.text.isEmpty){
                showMessage("Không để trống");
              }else{
                appProvider.addPet(image!,
                    name.text,
                    cannang.text,
                    age.text,
                    desc.text,
                    type.text,
                    sex.text,
               );
                showMessage("Cập nhật thành công");
              }
            },
          ),
        ],
      )
    );
  }
}
