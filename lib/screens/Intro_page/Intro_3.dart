

import 'package:flutter/material.dart';
import 'package:app_pet_shop/constants/routes.dart';
import '../auth_ui/sign_up/sign_up.dart';
import '../auth_ui/welcome/welcome.dart';



class Intro3 extends StatefulWidget {
  const Intro3({Key? key}) : super(key: key);

  @override
  State<Intro3> createState() => _Intro3State();
}

class _Intro3State extends State<Intro3> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 970,
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/intro3.png'),
            ),
          ),
          Positioned(
            top: 550,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              decoration: BoxDecoration(
                color: Color(0xFF90CAF9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ) ,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                  const Text(
                    '\t Chúng tôi cung cấp ! ',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\t \t \t \t Nhanh chóng & đầy đủ \n cho mọi yêu cầu của khách hàng',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height:5
                  ),
                  ElevatedButton(
                    onPressed: (){Routes.instance.push(widget: Welcome(), context: context);},
                    child: Text(
                      'Bắt đầu'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10)),
                        foregroundColor:
                        MaterialStateProperty.all(Colors.blue[400]),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)))),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );


  }
}
