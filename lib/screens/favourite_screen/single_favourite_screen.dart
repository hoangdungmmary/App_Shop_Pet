

import 'package:app_pet_shop/models/product_models/product_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../provider/app_provider.dart';

class SingleFavoriteItem extends StatefulWidget {
  final ProductModels singleProduct;
  const SingleFavoriteItem({super.key, required this.singleProduct});

  @override
  State<SingleFavoriteItem> createState() => _SingleFavoriteItemState();
}

class _SingleFavoriteItemState extends State<SingleFavoriteItem> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border:Border.all(color: Colors.red,width: 2.3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 150,
              color: Colors.red.withOpacity(0.5),
              child: Image.network(widget.singleProduct.image,),
            ),
          ),

          Expanded(
            flex: 1,
            child: SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.singleProduct.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black,
                              ),),
                             CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  AppProvider appProvder = Provider.of<AppProvider>(context,listen: false);
                                  appProvder.removefavouriteProduct(widget.singleProduct);
                                  showMessage("Xóa Hàng khỏi giỏ");
                                },
                                child:const Text(
                                  "Xóa sản phẩm yêu thích",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


        ],
      ),


    );
  }
}
