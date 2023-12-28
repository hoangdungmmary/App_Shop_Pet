

import 'package:app_pet_shop/models/category_model/category_model.dart';
import 'package:app_pet_shop/screens/Product_details/ProductDetails.dart';
import 'package:app_pet_shop/widgets/top_titles/top_titles.dart';
import 'package:flutter/material.dart';
import 'package:app_pet_shop/firebase_helper/frebase_firestore/firebase_firestore.dart';
import '../../constants/routes.dart';
import '../../models/product_models/product_models.dart';

class CategoryView extends StatefulWidget {
  final CategoryModels categoryModels;
  const CategoryView({super.key, required this.categoryModels});



  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModels> productModelList =[];
  bool isLoading = false;
  void getCategoryList() async{
    setState(() {
      isLoading = true;
    });
    productModelList =  await FirebaseFirestoreHelper.instance.getCategoryViewProduct(widget.categoryModels.id);
    setState(() {
      isLoading = false;
    });
  }

  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:isLoading?Center(
            child: Container(
            height: 100,
              width: 100,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
    ):SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kToolbarHeight+1),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const BackButton(),
                      Text(
                          widget.categoryModels.name
                        ,style:const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                ],
              ),
            ),
          productModelList.isEmpty
              ?const Center(child: Text("Sản phẩm trống"),) :
          SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: productModelList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 15,
                childAspectRatio: 0.6,
                crossAxisSpacing: 15,
                crossAxisCount: 2),
            itemBuilder: (ctx,index){
              ProductModels singleProduct = productModelList[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetails(singleProduct: singleProduct)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Image.network(singleProduct.image,height: 100,width: 100,),
                      ),
                    ),
                    const SizedBox(height:12),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(singleProduct.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),),
                    ),
                    const SizedBox(height:12),
                    Text("\$${singleProduct.gia}"),
                    const SizedBox(height: 6),
                    const SizedBox(height: 6),
                    ElevatedButton(
                      onPressed: (){Routes.instance.pushAndRemoveUntil(widget: ProductDetails(singleProduct: singleProduct), context: context);},
                      child: Text(
                        'Xem Thêm',
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
              );
            }
        ),
      ),
          ),
      ],
            ),
    )
    );
  }
}
