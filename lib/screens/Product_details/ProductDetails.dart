
import 'package:app_pet_shop/constants/constants.dart';
import 'package:app_pet_shop/constants/routes.dart';
import 'package:app_pet_shop/models/comment/commentModels.dart';
import 'package:app_pet_shop/models/product_models/product_models.dart';
import 'package:app_pet_shop/provider/app_provider.dart';
import 'package:app_pet_shop/screens/Home/Home.dart';
import 'package:app_pet_shop/screens/buy_product/buy_product.dart';
import 'package:app_pet_shop/screens/cart_screen/cart_screen.dart';
import 'package:app_pet_shop/screens/favourite_screen/favourite_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../firebase_helper/frebase_firestore/firebase_firestore.dart';
import '../Comment_Screen/Comment_screnn.dart';

class ProductDetails extends StatefulWidget {
  final ProductModels singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int query =1;
  @override




  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.push(
            context,

            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          ),
          child: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        actions: [
          IconButton(onPressed: (){
            Routes.instance.push(widget: CartScreen(), context: context);
          },
              icon: Icon(Icons.shopping_cart))
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 2,left: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(widget.singleProduct.image,
                height: 300,
                width: 300,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.singleProduct.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(onPressed: (){
                      setState(() {
                        widget.singleProduct.fav =!widget.singleProduct.fav;
                      });
                      if(   widget.singleProduct.fav){
                        appProvider.addfavouriteProduct( widget.singleProduct);
                      }else
                      {
                        appProvider.removefavouriteProduct( widget.singleProduct);
                      }
                    },
                      icon: Icon( appProvider.getfavouriteProductList.contains( widget.singleProduct)
                          ?Icons.favorite
                          :Icons.favorite_border,color: Colors.red,size: 30,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12,),
              Text(
                "Giá :  ${widget.singleProduct.gia.toString()} VND",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800]
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Text("Chi tiết sản phẩm:",style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ),
              SizedBox(height: 20,),
              Text(widget.singleProduct.desc,style: const TextStyle(
                fontSize: 20,
              ),),
              const SizedBox(height: 20),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: (){
                      setState(() {
                        if(query>=1){
                          setState(() {
                            query--;
                          });
                        }
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(query.toString(),style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                  const SizedBox(height: 12),
                  CupertinoButton(
                    onPressed: (){
                      setState(() {
                        if(query< widget.singleProduct.sl){
                          setState(() {
                            query++;
                          });
                        }
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(onPressed: (){
                    AppProvider appProvider = Provider.of<AppProvider>(context,listen: false);
                    ProductModels productModels = widget.singleProduct.copyWith(query: query);
                    appProvider.addCartProduct(productModels);
                    showMessage("Thêm vào giỏ hàng");
                  },
                    child: const Text("Bỏ vào giỏ"),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    height: 38,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: (){
                        ProductModels productModels = widget.singleProduct.copyWith(query: query);
                        Routes.instance.push(widget: CheckOut(singleProduct:productModels), context: context);
                      },
                      child: const Text("Mua Hàng"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              // SizedBox(height: 20),
              // Text(
              //   "Bình luận:",
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 10),
              // SizedBox(height: 10),
              // TextField(
              //   controller: commentController,
              //   decoration: InputDecoration(
              //     hintText: 'Nhập bình luận của bạn...',
              //   ),
              // ),
              // SizedBox(height: 10),
              // TextButton(
              //   onPressed: () async {
              //     appProvider.addcmt(commentController.text);
              //   },
              //   child: Text('Bình luận'),
              // ),
              // SizedBox(height: 80,),
            ],
          ),
        ),
      ),
    );
  }
}
