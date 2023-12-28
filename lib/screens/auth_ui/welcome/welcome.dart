import 'package:app_pet_shop/constants/assets_images.dart';
import 'package:app_pet_shop/constants/routes.dart';
import 'package:app_pet_shop/screens/auth_ui/login/login.dart';
import 'package:app_pet_shop/screens/auth_ui/sign_up/sign_up.dart';
import 'package:app_pet_shop/widgets/primary_button/primary_button.dart';
import 'package:app_pet_shop/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(subtitles: "Mang đến những thứ tốt nhất cho bạn!",title: "Chào Mừng!",),
              Center(
                child: Image.asset(
                    AssetsImages.instance.welcomeImage),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              const SizedBox(height: 18),
              PrimaryButton(title: "Đăng Nhập",onPressed: (){
                Routes.instance.push(widget: const Login(),context: context);
              },),
              const SizedBox(height: 18),
              PrimaryButton(title: "Đăng Ký",onPressed: (){
                Routes.instance.push(widget: SignUp(), context: context);
              },),
            ],
          ),
        ),
      ),
    );
  }
}
