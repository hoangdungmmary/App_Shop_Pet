
import 'package:app_pet_shop/firebase_helper/frebase_firestore/firebase_firestore.dart';
import 'package:app_pet_shop/models/order_models/order_models.dart';
import 'package:app_pet_shop/models/product_models/product_models.dart';
import 'package:app_pet_shop/provider/app_provider.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // Loadding lại trang
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    int activeStep = 4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Đặt Hàng",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child:  Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:  EasyStepper(
                  activeStep: activeStep,
                  stepShape: StepShape.rRectangle,
                  stepBorderRadius: 15,
                  borderThickness: 2,
                  stepRadius: 28,
                  finishedStepBorderColor: Colors.deepOrange,
                  finishedStepTextColor: Colors.deepOrange,
                  finishedStepBackgroundColor: Colors.deepOrange,
                  activeStepIconColor: Colors.deepOrange,
                  showLoadingAnimation: false,
                  steps: [
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 0 ? 1 : 0.3,
                          child: Image.asset('assets/images/shopping-cart (1).png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Mua Hàng',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 1 ? 1 : 0.3,
                          child: Image.asset('assets/images/shopping-cart.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Chờ xác nhận đơn hàng',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 2 ? 1 : 0.3,
                          child: Image.asset('assets/images/fast-delivery.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Giao Hàng',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 3 ? 1 : 0.3,
                          child: Image.asset('assets/images/received.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Nhận hàng thành công',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  onStepReached: (index) => setState(() => activeStep = index),
                ),
              ),
              const SizedBox(height: 10,),

              const Text("Danh sách Mua Hàng",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),),
              const SizedBox(height: 10,),
              Expanded(
                child: FutureBuilder(
                  future: FirebaseFirestoreHelper.instance.getUserOrder(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(snapshot.data!.isEmpty ||
                        snapshot.data == null ||
                        !snapshot.hasData){
                      return const Center(
                        child: Text("Không có Đơn Hàng"),
                      );
                    }
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context,index){
                          OrderModels orderModels = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              collapsedShape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.red,width: 2.3)),
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.red,width: 2.3)),
                              title:SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(

                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [

                                    Container(
                                      height: 130,
                                      width: 130,
                                      color: Colors.red.withOpacity(0.5),
                                      child: Image.network(
                                        orderModels.products[0].image,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text( orderModels.products[0].name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          orderModels.products.length >1
                                              ? SizedBox.fromSize()
                                              : Column(
                                            children: [
                                              Text(
                                                "Số lượng:${orderModels.products[0].query.toString()}",style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                              ),
                                              const SizedBox(height: 12),
                                            ],
                                          ),
                                          Text(
                                            "Tổng tiền :${orderModels.totalPrice.toString()} VND",style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            "Trạng Thái :${orderModels.status}",style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            "Ngày đặt hàng :${orderModels.ngayorder}",style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                          ),
                                          const SizedBox(height: 12),
                                          orderModels.status == "Xử lý"||
                                              orderModels.status == "Vận Chuyển"
                                              ? ElevatedButton(
                                            onPressed: () async {

                                              await   FirebaseFirestoreHelper.instance
                                                  .updateOrder(orderModels, "Hủy");
                                              orderModels.status ="Hủy";

                                              setState(() {

                                              });
                                            },
                                            child: const Text("Hủy Đơn Hàng"),
                                          )
                                              :SizedBox.fromSize(),
                                          orderModels.status == "Vận Chuyển"
                                              ? ElevatedButton(
                                            onPressed: () async {
                                              await  FirebaseFirestoreHelper.instance
                                                  .updateOrder(orderModels, "Hoàn Thành");
                                              orderModels.status ="Hoàn Thành";
                                              if(orderModels.status == "Hoàn Thành"){
                                                await FirebaseFirestoreHelper.instance.updatesl(orderModels.products as ProductModels, orderModels.products[0].sl - orderModels.products[0].query );
                                              }
                                              setState(() {

                                              });
                                            },
                                            child: const Text("Đã nhận Hàng"),
                                          )
                                              :SizedBox.fromSize(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              children:orderModels.products.length >1
                                  ? [
                                const Divider(color: Colors.red,),
                                ...orderModels.products.map((singleProduct) {
                                  return Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.baseline,
                                            textBaseline: TextBaseline.alphabetic,
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                color: Colors.red.withOpacity(0.5),
                                                child: Image.network(
                                                  singleProduct.image,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text( singleProduct.name,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Số lượng:${singleProduct.query.toString()}",style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                        ),
                                                        const SizedBox(height: 12),
                                                      ],
                                                    ),
                                                    Text(
                                                      "Giá :${singleProduct.gia.toString()} VND",style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(color: Colors.red,)
                                      ],
                                    ),
                                  );
                                }).toList()
                              ]
                                  :[

                              ],
                            ),
                          );
                        });
                  },),
              )
            ],
          ),
        )
      ),
    );
  }

  // Hàm loadding
  Future<void> _handleRefresh() async {
    setState(() {
    });
  }
}
