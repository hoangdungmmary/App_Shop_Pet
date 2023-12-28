


import 'package:app_pet_shop/models/Service_Models/Service_Models.dart';
import 'package:app_pet_shop/screens/Product_details/ProductDetails.dart';
import 'package:app_pet_shop/screens/Service_detail/Service_detail.dart';
import 'package:flutter/material.dart';
import 'package:app_pet_shop/firebase_helper/frebase_firestore/firebase_firestore.dart';
import '../../constants/routes.dart';
import '../../models/category_model/category_Servive_model.dart';
import '../../models/product_models/product_models.dart';

class CategoryServiceView extends StatefulWidget {
  final CategoryServiceModels categoryServiceModels;
  const CategoryServiceView({super.key, required this.categoryServiceModels, });



  @override
  State<CategoryServiceView> createState() => _CategoryServiceViewState();
}

class _CategoryServiceViewState extends State<CategoryServiceView> {
  List<ServiceModels> serviceModelList =[];
  bool isLoading = false;
  void getCategoryList() async{
    setState(() {
      isLoading = true;
    });
    serviceModelList =  await FirebaseFirestoreHelper.instance.getServiceViewProduct(widget.categoryServiceModels.id);
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
                      widget.categoryServiceModels.name
                      ,style:const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                    ),
                    ),
                  ],
                ),
              ),
              serviceModelList.isEmpty
                  ?const Center(child: Text("Không có dịch vụ"),) :
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: serviceModelList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 15,
                          crossAxisCount: 2),
                      itemBuilder: (ctx,index){
                        ServiceModels singleService = serviceModelList[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Image.network(singleService.image,height: 100,width: 100,),
                              ),
                              const SizedBox(height:12),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(singleService.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),),
                              ),
                              const SizedBox(height:12),
                              Text("\$${singleService.gia}"),
                              const SizedBox(height: 6),
                              ElevatedButton(
                                onPressed: (){  Routes.instance.pushAndRemoveUntil(widget: ServiceDetails(singleService: singleService), context: context);},
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
