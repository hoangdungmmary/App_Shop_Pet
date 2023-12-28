
import 'dart:io';


import 'package:app_pet_shop/models/pet_Models/pet_Models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../firebase_helper/firebase_storage/firebase_storage.dart';
import '../../../provider/app_provider.dart';


class EditPet extends StatefulWidget {
  final PetModels petModels;
  final int index;
  const EditPet({Key? key, required this.petModels, required this.index}) : super(key: key);

  @override
  State<EditPet> createState() => _EditPetState();
}

class _EditPetState extends State<EditPet> {

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
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Chỉnh sửa Thông tin thú cưng",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image ==null
              ? widget.petModels.image.isNotEmpty
              ? CupertinoButton(
            onPressed: (){
              takePicture();
            },
            child: CircleAvatar(
              radius: 70,
              backgroundImage:NetworkImage(widget.petModels.image),
            ),
          )
              : CupertinoButton(
            onPressed: (){
              takePicture();
            },
            child: CircleAvatar(
              radius: 70,
              child:
              const Icon(Icons.camera_alt),
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
            decoration: InputDecoration(
              hintText:widget.petModels.name,
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: type,
            maxLines: 10,
            decoration: InputDecoration(
              hintText:widget.petModels.type,
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: cannang,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText:"Cân nặng",
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: age,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText:"Tuổi",
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: desc,
            maxLines: 10,
            decoration: InputDecoration(
              hintText:widget.petModels.desc,
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: sex,
            maxLines: 10,
            decoration: InputDecoration(
              hintText:widget.petModels.sex,
            ),
          ),
          ElevatedButton(
            child:Text("Cập Nhật") ,
            onPressed: () async{
              if(image == null && name.text.isEmpty && desc.text.isEmpty && age.text.isEmpty
                  && cannang.text.isEmpty&& type.text.isEmpty&& sex.text.isEmpty){
                Navigator.of(context).pop();
              }else if(image!= null){

                String imageUrl =
                await FirebaseStorageHelper.instance
                    .uploadUserImagePet(widget.petModels.id,image!);
                PetModels petModels = widget.petModels.copyWith(
                  desc : desc.text.isEmpty?null:desc.text,
                  image : imageUrl,
                  name : name.text.isEmpty?null:name.text,
                  age : age.text.isEmpty?null:age.text,
                  type : type.text.isEmpty?null:type.text,
                  sex : sex.text.isEmpty?null:sex.text,
                  cannang : cannang.text.isEmpty?null:cannang.text,
                );
                appProvider.updatePetList(widget.index, petModels);
                showMessage("Cập nhật thành công");
              }
              else{

                PetModels petModels = widget.petModels.copyWith(
                  desc : desc.text.isEmpty?null:desc.text,
                  name : name.text.isEmpty?null:name.text,
                  age : age.text.isEmpty?null:age.text,
                  type : type.text.isEmpty?null:type.text,
                  sex : sex.text.isEmpty?null:sex.text,
                  cannang : cannang.text.isEmpty?null:cannang.text,
                );
                appProvider.updatePetList(widget.index, petModels);
                showMessage("Cập nhật thành công");
              }
              //
            },
          ),
        ],
      ),
    );
  }
}
