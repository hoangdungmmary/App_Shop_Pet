
import 'package:app_pet_shop/firebase_helper/firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../provider/app_provider.dart';
import '../../widgets/primary_button/primary_button.dart';
import '../account_screen/account_screen.dart';
import '../change_password/change_password.dart';
import '../custom_bottom_bar/custom_bottom_bar.dart';
import '../edit_profile/edit_profile.dart';


class DrawerBanner extends StatefulWidget {
  const DrawerBanner({Key? key}) : super(key: key);

  @override
  State<DrawerBanner> createState() => _DrawerBannerState();
}

class _DrawerBannerState extends State<DrawerBanner> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context,);
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                appProvider.getUserfomation.image==null
                    ?const Icon(
                  Icons.person_outline,
                  size: 60,)
                    :CircleAvatar(
                  radius: 50,
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
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        ListTile(
          title: const Text(
            'Trang chủ',
            style: TextStyle(fontSize: 18),
          ),
          leading: const Icon(
            Icons.home,
            size: 30,
            color: Color(0xFF1E88E5),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CustomsBottomBar()));
          },
        ),
        ListTile(
          title: const Text(
            'Thông tin người dùng',
            style: TextStyle(fontSize: 18),
          ),
          leading: const Icon(
            Icons.settings,
            size: 30,
            color: Color(0xFF1E88E5),
          ),
          onTap: (){
            Routes.instance.push(widget: const AcountScreen(), context: context);
          },
        ),
        ListTile(
          title: const Text(
            'Thay đổ mật khẩu',
            style: TextStyle(fontSize: 18),
          ),
          leading: const Icon(
            Icons.settings,
            size: 30,
            color: Color(0xFF1E88E5),
          ),
          onTap: (){
            Routes.instance.push(widget: const ChangePassword(), context: context);
          },
        ),
        const Divider(
          color: Color(0xFF1E88E5),
        ),
        ListTile(
          title: const Text(
            'Đăng xuất',
            style: TextStyle(fontSize: 18),
          ),
          leading: const Icon(
            Icons.logout,
            size: 30,
            color: Color(0xFF1E88E5),
          ),
          onTap: (){
            FirebaseAuthHelper.instance.singOut();
            setState(() {
            });
          },
        ),
      ],
    );
  }
}
