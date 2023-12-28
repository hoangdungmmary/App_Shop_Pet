
import 'package:app_pet_shop/screens/account_screen/account_screen.dart';
import 'package:app_pet_shop/screens/cart_screen/cart_screen.dart';
import 'package:app_pet_shop/screens/favourite_screen/favourite_screen.dart';
import 'package:app_pet_shop/screens/order_screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../Home/Home.dart';
import '../Servive_Screen/Service_Screen.dart';
import '../traning_screen/traning_screen.dart';

class CustomsBottomBar extends StatefulWidget {
  const CustomsBottomBar({final Key? key})
      : super(key: key);


  @override
  _CustomsBottomBarState createState() => _CustomsBottomBarState();
}

class _CustomsBottomBarState extends State<CustomsBottomBar> {

  PersistentTabController _controller = PersistentTabController();
  bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
    const Home(),
    const ServiceScreen (),
    const TraningScreen(),
    const OrderScreen(),
    const AcountScreen(),


  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Trang Chủ",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
     ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.design_services),
      title: "Dịch vụ",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.pets),
      title: "Huấn luyện",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.shopping_bag_outlined),
      title: "Đặt Hàng",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: "Cá Nhân",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white,
    ),

  ];

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      resizeToAvoidBottomInset: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : kBottomNavigationBarHeight,
      bottomScreenMargin: 0,
      backgroundColor: Theme.of(context).primaryColor,
      hideNavigationBar: _hideNavBar,
      decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
      ),
      navBarStyle: NavBarStyle
          .style1, // Choose the nav bar style with this property
    ),
  );
}