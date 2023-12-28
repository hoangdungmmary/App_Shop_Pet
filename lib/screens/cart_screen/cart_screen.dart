
import 'package:app_pet_shop/constants/constants.dart';
import 'package:app_pet_shop/screens/buy_product/buy_product.dart';
import 'package:app_pet_shop/screens/cart_item_checkout/cart_item_checkout.dart';
import 'package:app_pet_shop/screens/widgets/singleCartItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../firebase_helper/frebase_firestore/firebase_firestore.dart';
import '../../provider/app_provider.dart';
import '../../widgets/primary_button/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int query =1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvder = Provider.of<AppProvider>(
        context,);


    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Thành Tiền",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  Text("${appProvder.totalPrice().toString()} VND",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              ),
              SizedBox(height: 24),
              PrimaryButton(title: "Thanh Toán",
                onPressed: ()  async {
                  appProvder.clearBuyProduct();
                  appProvder.addBuyProductCartList();
                  appProvder.clearCart();
                  if(appProvder.getBuyProductList.isEmpty){
                        showMessage("Giỏ hàng rỗng");
                  }else{
                    Routes.instance
                        .push(widget: CartItemCheckOut(), context: context);
                  }

                },)
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
       title: const Text("Giỏ Hàng Của Bạn",
       style: TextStyle(
         color: Colors.black,
       ),),
      ),
      body: appProvder.getCartProductList.isEmpty?const Center(child: Text("Giỏ Hàng trống"),): ListView.builder(
        itemCount: appProvder.getCartProductList.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (ctx,index){
          return SingleCartitem(
            singleProduct: appProvder.getCartProductList[index],

          );
        },

      ),
    );
  }
}
