

import 'dart:developer';

import 'package:app_pet_shop/firebase_helper/frebase_firestore/firebase_firestore.dart';
import 'package:app_pet_shop/models/category_model/category_Servive_model.dart';
import 'package:app_pet_shop/provider/app_provider.dart';
import 'package:app_pet_shop/screens/category_service_view/category_service_view.dart';
import 'package:app_pet_shop/screens/category_view/category_view.dart';
import 'package:app_pet_shop/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/routes.dart';
import '../../models/Service_Models/Service_Models.dart';
import '../../models/product_models/product_models.dart';
import '../DrawerBanner/DrawerBanner.dart';
import '../NavBar/NavBar.dart';
import '../Product_details/ProductDetails.dart';
import '../Service_detail/Service_detail.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  List<CategoryServiceModels> categoriesServiceList =[];
  List<ServiceModels> serviceModelList =[];
  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryServiceList();
    super.initState();
  }


  void getCategoryServiceList() async{
    setState(() {
      isLoading = true;
    });
    categoriesServiceList =  await FirebaseFirestoreHelper.instance.getServices();
    serviceModelList =  await FirebaseFirestoreHelper.instance.getServiceProducts();

    serviceModelList.shuffle();
    setState(() {
      isLoading = false;
    });

  }

  TextEditingController search = TextEditingController();
  List<ServiceModels> searchList = [];
  void searchProduct(String value){
    searchList = serviceModelList
        .where((element) => element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    print(searchList.length);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.blue[200],
        child: const DrawerBanner(),
      ),
      appBar: AppBar(
        title: const Text('Dịch vụ'
          ,style: TextStyle(
              color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: const Color(0xFF1E88E5),
      ),
      body:isLoading
          ?Center(

        child: Container(
          // child: Text('trong'),
          height: 100,
          width: 100,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      )
          :SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const TopTitles(subtitles: "Mang đến những thứ tốt nhất cho thú cưng",title: "Thú cưng Shop",),
                  const SizedBox(height: 12),
                  BannerToy(),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: search,
                    onChanged: (String value ){
                      searchProduct(value);
                    },
                    decoration: const InputDecoration(hintText: "Tìm kiếm..."),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Text("Thể Loại",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),),
            ),
            categoriesServiceList.isEmpty
                ?Center(child: Text("Dịch vụ trống"),)
                :
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:  categoriesServiceList.map(
                      (e)=> Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        Routes.instance.push(widget: CategoryServiceView(categoryServiceModels: e), context: context);
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child:Column(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child:Image.network(e.image),
                            ),
                            Text(e.name,style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ),
            SizedBox(height: 12),
            Text("Bảng Giá",   style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black,
            ),),
            SizedBox(height: 12),
            Container(
              child: Image.asset("assets/images/bang_gia.png"),
            ),
            !isSearch() ? const Padding(
              padding: EdgeInsets.only(top:12, left: 12),
              child: Text("Dịch vụ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),),
            ):SizedBox.fromSize(),
            const SizedBox(height: 12),
            search.text.isNotEmpty && searchList.isEmpty
                ? Center(child: Text("Không tìm Thấy"),)
                :searchList.isNotEmpty?  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: searchList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 15,
                        crossAxisCount: 2),
                    itemBuilder: (ctx,index){
                      ServiceModels singleService = searchList[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 6
                              ),
                            ]
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
                            Text("${singleService.gia} VND"),
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
            ): serviceModelList.isEmpty?
            Center(child: Text("Dịch vụ trống"),) :
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
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 6
                              ),
                            ]
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
                            Text("${singleService.gia} VND"),
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
                            // SizedBox(
                            //   height: 45,
                            //   width: 140,
                            //   child: OutlinedButton(
                            //     onPressed: (){
                            //       Routes.instance.pushAndRemoveUntil(widget: ServiceDetails(singleService: singleService), context: context);
                            //     },
                            //     child: const Text("Xem Thêm",style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //     ),
                            //   ),
                            // ),

                          ],
                        ),
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isSearch(){
    if(   search.text.isNotEmpty && searchList.isEmpty || searchList.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
}



