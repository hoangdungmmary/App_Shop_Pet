
import 'package:app_pet_shop/constants/routes.dart';
import 'package:app_pet_shop/firebase_helper/firebase_auth/firebase_auth.dart';
import 'package:app_pet_shop/screens/favourite_screen/favourite_screen.dart';
import 'package:app_pet_shop/screens/favourite_screen/favourite_service_screen.dart';
import 'package:app_pet_shop/screens/pet_screen/pet_view.dart';
import 'package:app_pet_shop/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../change_password/change_password.dart';
import '../edit_profile/edit_profile.dart';
import '../order_service_screen/order_service_screen.dart';
import '../traning_screen/traning_screen.dart';

class AcountScreen extends StatefulWidget {
   const AcountScreen({Key? key}) : super(key: key);

  @override
  State<AcountScreen> createState() => _AcountScreenState();
}

class _AcountScreenState extends State<AcountScreen> {
  @override
   Widget build(BuildContext context) {

     AppProvider appProvider = Provider.of<AppProvider>(context,);
     return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         backgroundColor: Colors.white,
         title: const Text("Tài Khoản",style:TextStyle(
           color: Colors.black,

         ),),
       ),
       body: Column(
         children: [
           Expanded(
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                     appProvider.getUserfomation.image==null
                     ?const Icon(
                       Icons.person_outline,
                       size: 130,
                     )
                         :CircleAvatar(
                       radius: 70,
                       backgroundImage:NetworkImage( appProvider.getUserfomation.image!),
                     ),
                    Text(appProvider.getUserfomation.name,
                      style: const TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 22,
                     ),),
                Text(appProvider.getUserfomation.email),
                     const SizedBox(height: 12),
                     SizedBox(
                       width: 150,
                       child: PrimaryButton(
                         onPressed: (){
                           Routes.instance.push(widget: const EditProfile(), context: context);
                         },
                         title: "Chỉnh sửa",),
                     )
                   ],
                 ),
               )
           ),
           Expanded(
             flex: 2,
             child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ListTile(
                      //   onTap: ()
                      //   {Routes.instance.push(widget: const TraningScreen(), context: context);
                      //
                      //   },
                      //   leading: const Icon(Icons.pets,color: Color(0xFF64B5F6),),
                      //   title: const Text("Thú cưng của tôi"),
                      // ),
                      ListTile(
                        onTap: (){
                          Routes.instance.push(widget: const FavouriteScreen(), context: context);
                        },
                        leading: const Icon(Icons.favorite,color: Color(0xFF64B5F6),),
                        title: const Text("Sản phẩm yêu thích"),
                      ),
                      ListTile(
                        onTap: (){
                          Routes.instance.push(widget: const FavouriteServiceScreen(), context: context);
                        },
                        leading: const Icon(Icons.design_services,color: Color(0xFF64B5F6)),
                        title: const Text("Dịch vụ yêu thích"),
                      ),
                      ListTile(
                        onTap: (){
                            Routes.instance.push(widget: OrderServiceScreen(), context: context);
                        },
                        leading: const Icon(Icons.home_repair_service_rounded,color: Color(0xFF64B5F6)),
                        title: const Text("Dịch vụ đã đặt lịch"),
                      ),
                      ListTile(
                        onTap: (){
                          Routes.instance.push(widget: const ChangePassword(), context: context);
                        },
                        leading: const Icon(Icons.change_circle_outlined,color: Color(0xFF64B5F6)),
                        title: const Text("Thay đổ mật khẩu"),
                      ),
                      ListTile(
                        onTap: (){
                          FirebaseAuthHelper.instance.singOut();
                          setState(() {
                          });
                        },
                        leading: const Icon(Icons.login,color: Color(0xFF64B5F6)),
                        title: const Text("Đăng Xuất"),
                      ),



                      const SizedBox(height: 12),
                      const Text("Phiên bản 1.0.0"),
                    ],
                  ),
                ),
             ),
           )
         ],
       ),
     );
   }
}
