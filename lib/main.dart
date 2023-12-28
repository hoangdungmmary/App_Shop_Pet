import 'package:app_pet_shop/firebase_helper/firebase_auth/firebase_auth.dart';
import 'package:app_pet_shop/firebase_helper/firebase_options/firebase_options.dart';
import 'package:app_pet_shop/provider/app_provider.dart';
import 'package:app_pet_shop/screens/Intro_page/Screen_page.dart';
import 'package:app_pet_shop/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'constants/theme_colors.dart';
import 'screens/auth_ui/welcome/welcome.dart';

void main()  async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.playformOptions,
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App pet shop',
        theme: themeData,
         home:
        StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder:(context,snapshot){
            if(snapshot.hasData){
              return const CustomsBottomBar();
            }
            return const Screen();
          },
        ),
      ),
    );
  }
}

