

import 'package:app_pet_shop/models/product_models/product_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../provider/app_provider.dart';

class SingleCartitem extends StatefulWidget {
  final ProductModels singleProduct;
  const SingleCartitem({super.key, required this.singleProduct});

  @override
  State<SingleCartitem> createState() => _SingleCartitemState();
}

class _SingleCartitemState extends State<SingleCartitem> {
  int query =1;
  @override
  void initState(){
    query = widget.singleProduct.query ?? 1;
    setState(() {
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
                            FittedBox(
                              child: Text(widget.singleProduct.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),),
                            ),
                            Row(
                              children: [
                                CupertinoButton(
                                  onPressed: (){
                                    setState(() {
                                      if(query>1){
                                        setState(() {
                                         query--;
                                        });
                                        appProvider.updateQuery(widget.singleProduct, query);
                                      }
                                    });
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.remove),
                                  ),
                                ),

                                Text(
                                  widget.singleProduct.query.toString(),style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),

                                CupertinoButton(
                                  onPressed: (){

                                    setState(() {
                                      if(query< widget.singleProduct.sl){
                                        setState(() {
                                          query++;
                                        });
                                      }
                                    });
                                    appProvider.updateQuery(widget.singleProduct, query);


                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.add),
                                  ),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: (){
                                    appProvider.removeCartProduct(widget.singleProduct);
                                    showMessage("Xóa Hàng khỏi giỏ");
                                  },
                                  child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.delete,size: 17,),
                                  ),
                                ),
                              ],

                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: (){
                                    if(!appProvider.getfavouriteProductList.contains
                                      ( widget.singleProduct)){
                                      appProvider.addfavouriteProduct( widget.singleProduct);
                                    }else
                                    {
                                      appProvider.removefavouriteProduct( widget.singleProduct);
                                    }
                                  },
                                  child: Text(
                                    appProvider.getfavouriteProductList.contains( widget.singleProduct)
                                        ? "Xóa khỏi danh sách yêu thích"
                                        :"Thêm vào danh sách yêu thích",
                                    style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),),
                                ),

                              ],

                            ),

                            Text("Giá :${widget.singleProduct.gia.toString()} VND",style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),),

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
