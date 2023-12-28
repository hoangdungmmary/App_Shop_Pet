
import 'package:app_pet_shop/constants/constants.dart';
import 'package:app_pet_shop/firebase_helper/firebase_auth/firebase_auth.dart';
import 'package:app_pet_shop/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confrompassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Đổi mật khẩu",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            decoration:InputDecoration(
              hintText: "Mật Khẩu mới",
              prefixIcon: Icon(Icons.password),
              suffixIcon: CupertinoButton(
                onPressed: (){
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                padding: EdgeInsets.zero,
                child: Icon(Icons.visibility,color: Colors.black87,),
              ),
            ),
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: confrompassword,
            obscureText: isShowPassword,
            decoration:InputDecoration(
              hintText: "Nhập lại mật khẩu",
              prefixIcon: Icon(Icons.password),
              suffixIcon: CupertinoButton(
                onPressed: (){
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                padding: EdgeInsets.zero,
                child: Icon(Icons.visibility,color: Colors.black87,),
              ),
            ),
          ),
          SizedBox(height: 12),
          PrimaryButton(
            title: "Cập Nhật",
            onPressed: () async{
              if(newpassword.text.isEmpty){
                showMessage("Mật khẩu mới bị rỗng");
              }else if(confrompassword.text.isEmpty){
                showMessage("Mật khẩu bị rỗng");

              }else if(confrompassword.text == newpassword.text){
                FirebaseAuthHelper.instance
                    .changePassword(newpassword.text, context);
              }else
              {
                showMessage("Mật khẩu không khóp");
              }

            },
          ),
        ],
      ),
    );
  }
}
