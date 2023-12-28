import 'package:app_pet_shop/constants/constants.dart';
import 'package:app_pet_shop/constants/routes.dart';
import 'package:app_pet_shop/firebase_helper/firebase_auth/firebase_auth.dart';
import 'package:app_pet_shop/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:app_pet_shop/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_pet_shop/widgets/top_titles/top_titles.dart';

import '../login/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email= TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone= TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController Diachi = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/home2.JPG",
                        height: 150,
                        width: 150,
                      ),
                    ),
                    TopTitles(title: "Đăng Ký", subtitles:"Chào mừng bạn đến với Pet Shop" ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: 15),
                          TextFormField(

                            controller: name,
                            decoration: InputDecoration(
                              hintText: "Tên Đăng Nhập",
                              prefixIcon: Icon(Icons.person_sharp,
                                color: Color(0xFF64B5F6),
                                size: 30.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: email,
                            decoration:InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(Icons.email,
                                  color: Color(0xFF64B5F6),
                                  size: 30.0,),
                                border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                            filled: true,
                            fillColor: Colors.white,
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: Diachi,
                            decoration:  InputDecoration(
                                hintText: "Địa Chỉ",
                                prefixIcon: Icon(Icons.home_rounded,
                                  color: Color(0xFF64B5F6),
                                  size: 30.0,),
                                border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                            filled: true,
                            fillColor: Colors.white,
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "SDT",
                              prefixIcon: Icon(Icons.phone,
                                color: Color(0xFF64B5F6),
                                size: 30.0,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),

                          SizedBox(height: 15),
                          TextFormField(
                            controller: password,
                            obscureText: isShowPassword,
                            decoration:InputDecoration(
                              hintText: "Mật Khẩu",
                              prefixIcon: Icon(Icons.password,
                                color: Color(0xFF64B5F6),
                                size: 30.0,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: CupertinoButton(
                                onPressed: (){
                                  setState(() {
                                    isShowPassword = !isShowPassword;
                                    print(isShowPassword);
                                  });
                                },
                                padding: EdgeInsets.zero,
                                child: Icon(Icons.visibility,color: Colors.black87,),
                              ),
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          PrimaryButton(title: "Đăng Ký",
                            onPressed: () async{
                              bool isVaildate = signupVaildation(email.text, password.text, name.text, phone.text,Diachi.text);
                              if(isVaildate){
                                bool isLogined = await FirebaseAuthHelper.instance.signup(name.text,email.text, password.text, phone.text,Diachi.text,context);
                                if(isLogined){
                                  Routes.instance.pushAndRemoveUntil(widget: const CustomsBottomBar(), context: context);
                                }
                              }
                            },),
                          SizedBox(height: 12),
                          Center(
                            child:Text("Bạn đã có tài khoản chưa?",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white
                            ),),
                          ),
                          SizedBox(height: 5),
                          Center(child: CupertinoButton(
                            onPressed: (){
                              Routes.instance.push(widget: const Login(),context: context);
                            },
                            child: Text("Đăng Nhập",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
