import 'package:app_pet_shop/constants/constants.dart';
import 'package:app_pet_shop/constants/routes.dart';
import 'package:app_pet_shop/firebase_helper/firebase_auth/firebase_auth.dart';
import 'package:app_pet_shop/screens/Home/Home.dart';
import 'package:app_pet_shop/screens/auth_ui/sign_up/sign_up.dart';
import 'package:app_pet_shop/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:app_pet_shop/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_pet_shop/widgets/top_titles/top_titles.dart';

import '../ForgotPassword/Forgot_Password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email= TextEditingController();
  TextEditingController password = TextEditingController();
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
                        "assets/images/login.png",
                        height: 150,
                        width: 150,
                      ),
                    ),
                    TopTitles(title: "Đăng Nhập",
                        subtitles:"Chào mừng bạn đến với Pet Shop" ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 15),
                        TextFormField(

                          controller: email,
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email,
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

                          controller: password,
                          obscureText: isShowPassword,
                          decoration:InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Mật Khẩu",
                            prefixIcon: Icon(Icons.password,
                              color: Color(0xFF64B5F6),
                              size: 30.0,),
                            suffixIcon: CupertinoButton(
                              onPressed: (){
                                setState(() {
                                  isShowPassword = !isShowPassword;
                                  print(isShowPassword);
                                });
                              },
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.visibility, color: Color(0xFF64B5F6),
                                size: 20,),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ForgotPasswordPage();
                            }));
                          },
                          child: Text(
                            "Quên mật khẩu",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[50],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        PrimaryButton(title: "Đăng Nhập",
                          onPressed: () async {
                            bool isVaildate = loginVaildation(email.text, password.text);
                            if(isVaildate){
                              bool isLogined = await FirebaseAuthHelper.instance.login(email.text, password.text, context);
                              if(isLogined){
                                Routes.instance.pushAndRemoveUntil(widget: const CustomsBottomBar(), context: context);
                              }
                            }
                          },),
                        SizedBox(height: 12),
                        Center(
                          child:Text("Bạn chưa có tài khoản?",  style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                        ),
                        SizedBox(height: 12),
                        Center(child: CupertinoButton(
                          onPressed: (){Routes.instance.push(widget: SignUp(), context: context);}, child: Text("Tạo Tài Khoản!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[50],
                          ),
                        ),
                        )
                        ),
                      ],
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
