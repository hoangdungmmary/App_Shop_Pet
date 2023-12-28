
import 'package:app_pet_shop/firebase_helper/frebase_firestore/firebase_firestore.dart';
import 'package:app_pet_shop/models/product_models/product_models.dart';
import 'package:app_pet_shop/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../provider/app_provider.dart';
import '../custom_bottom_bar/custom_bottom_bar.dart';
import '../paypal_screen/paypal_screen.dart';

class CheckOut extends StatefulWidget {
  final ProductModels singleProduct;
  const CheckOut({super.key, required this.singleProduct,});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int groupvalue = 1;


  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Thanh Toán",
            style: TextStyle(
              color: Colors.black,
            ),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 36),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border:Border.all(
                  color: Theme.of(context).primaryColor,width: 3.0

                )
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(value :1, groupValue: groupvalue,  onChanged:(value){
                    setState(() {
                      groupvalue = value!;
                    });
                  }),
                  const Icon(Icons.money),
                  SizedBox(width: 10),
                  const Text("Thanh Toán khi nhận hàng",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),

                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border:Border.all(
                      color: Theme.of(context).primaryColor,width: 3.0
                  )
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(value :2, groupValue: groupvalue,  onChanged:(value){
                    setState(() {
                      groupvalue = value!;
                    });
                  }),
                  const Icon(Icons.money),
                  SizedBox(width: 12),
                  const Text("Thanh Toán bằng Card",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),

                ],
              ),
            ),
             const SizedBox(height: 24),
          PrimaryButton(
          title: "Tiếp tục",
            onPressed: () async {
            appProvider.getBuyProductList.clear();
            appProvider.addBuyProduct(widget.singleProduct);
              bool value = await FirebaseFirestoreHelper.instance
                  .uploadOrderProductFirebase(appProvider.getBuyProductList,
                  context, groupvalue ==1?"Thanh toán nhận hàng":"Thanh toán bằng Card");

              appProvider.clearBuyProduct();

              if(value){
                Future.delayed(const Duration(seconds: 2),(){
                  Routes.instance.push(widget: CustomsBottomBar(), context:context);
                });
              }
            },
          ),
          ],
        ),
      ),
    );
  }
}
