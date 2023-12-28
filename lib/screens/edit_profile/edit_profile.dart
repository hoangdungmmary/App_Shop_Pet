
import 'dart:io';

import 'package:app_pet_shop/constants/constants.dart';
import 'package:app_pet_shop/models/user_model/user_models.dart';
import 'package:app_pet_shop/provider/app_provider.dart';
import 'package:app_pet_shop/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController diachiEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Thông tin cá nhân",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body:  SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child:image ==null
                        ? CupertinoButton(
                      onPressed: (){
                        takePicture();
                      },
                      child: CircleAvatar(
                        radius: 70,
                        child: image==null? const Icon(Icons.camera_alt):Image.file(image!),
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
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color(0xFF90CAF9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )
                  ),
                  child: Padding(padding: const EdgeInsets.only(left:20.0, right: 20.0, top: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(padding: const EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 250),
                                child: const Text(
                                  'Họ tên:',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white

                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: nameEditingController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText:appProvider.getUserfomation.name,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(right: 250),
                                child: const Text(
                                  'Địa Chỉ:',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white

                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: diachiEditingController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText:appProvider.getUserfomation.Diachi,
                                ),
                              ),
                              const SizedBox(height:10),
                              Padding(
                                padding: const EdgeInsets.only(right: 260),
                                child: const Text('SDT:',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white

                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: phoneEditingController,
                                decoration: InputDecoration(

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,

                                  hintText:appProvider.getUserfomation.phone,

                                ),
                              ),

                              const SizedBox(height: 24),
                              PrimaryButton(
                                title: "Cập Nhật",
                                onPressed: () async{
                                  UserModels userModels = appProvider.getUserfomation.copyWith(
                                    name : nameEditingController.text.isEmpty?null:nameEditingController.text,
                                    phone : phoneEditingController.text.isEmpty?null:phoneEditingController.text,
                                    Diachi : diachiEditingController.text.isEmpty?null:diachiEditingController.text,);
                                  appProvider.updateUserInfoFirebase(context, userModels, image,);
                                  showMessage("Cập nhật thành công");
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                  ),

                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}
