
import 'package:app_pet_shop/firebase_helper/frebase_firestore/firebase_firestore.dart';
import 'package:app_pet_shop/models/order_models/order_models.dart';
import 'package:app_pet_shop/models/order_servce_models/order_service_models.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class OrderServiceScreen extends StatefulWidget {
  const OrderServiceScreen({Key? key}) : super(key: key);

  @override
  State<OrderServiceScreen> createState() => _OrderServiceScreenState();
}

class _OrderServiceScreenState extends State<OrderServiceScreen> {


  // Loadding lại trang
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    int activeStep =1;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Đặt Dịch vụ ",
            style: TextStyle(
              color: Colors.black,
            ),
          )
      ),
        body:  RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          child: Container(
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
                            child: Image.asset('assets/images/support.png'),
                          ),
                        ),
                        customTitle: const Text(
                          'Đặt Dịch vụ',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      EasyStep(
                        customStep: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Opacity(
                            opacity: activeStep >= 1 ? 1 : 0.3,
                            child: Image.asset('assets/images/clipboard.png'),
                          ),
                        ),
                        customTitle: const Text(
                          'Chờ xác nhận Đặt Dịch vụ',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      EasyStep(
                        customStep: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Opacity(
                            opacity: activeStep >= 3 ? 1 : 0.3,
                            child: Image.asset('assets/images/pet-friendly.png'),
                          ),
                        ),
                        customTitle: const Text(
                          'Xác nhận thành công',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      EasyStep(
                        customStep: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Opacity(
                            opacity: activeStep >= 3 ? 1 : 0.3,
                            child: Image.asset('assets/images/file.png'),
                          ),
                        ),
                        customTitle: const Text(
                          'Dịch vụ hoàn thành',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    onStepReached: (index) => setState(() => activeStep = index),
                  ),
                ),
                const SizedBox(height: 10,),

                const Text("Danh sách dịch vụ đã đặt",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),),
                const SizedBox(height: 10,),
                Expanded(
                  child:FutureBuilder(
                    future: FirebaseFirestoreHelper.instance.getUserOrderService(),
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
                          child: Text("Không có Dịch vụ"),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (context,index){
                            OrderServiceModels orderServiceModels = snapshot.data![index];
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
                                          orderServiceModels.service[0].image,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text( orderServiceModels.service[0].name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            orderServiceModels.service.length >1
                                                ? SizedBox.fromSize()
                                                : Column(
                                              children: [
                                                Text(
                                                  "Trọng lượng thú cưng:${orderServiceModels.service[0].trongluong.toString()}",style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                                ),
                                                const SizedBox(height: 12),
                                              ],
                                            ),
                                            Text(
                                              "Tổng tiền :${orderServiceModels.totalPrice.toString()} VND",style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              "Trạng Thái :${orderServiceModels.status}",style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              "Ngày hẹn :${orderServiceModels.date}",style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              "Thời gian :${orderServiceModels.time}",style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                            ),
                                            const SizedBox(height: 12),
                                            orderServiceModels.status == "Xử lý"||
                                                orderServiceModels.status == "Xác nhận"
                                                ? ElevatedButton(
                                              onPressed: () async {
                                                await   FirebaseFirestoreHelper.instance
                                                    .updateOrderService(orderServiceModels, "Hủy");
                                                orderServiceModels.status ="Hủy";
                                                setState(() {

                                                });
                                              },
                                              child: const Text("Hủy Lịch Hẹn"),
                                            )
                                                :SizedBox.fromSize(),
                                            orderServiceModels.status == "Xác nhận"
                                                ? ElevatedButton(
                                              onPressed: () async {
                                                await  FirebaseFirestoreHelper.instance
                                                    .updateOrderService(orderServiceModels, "Hoàn Thành");
                                                orderServiceModels.status ="Hoàn Thành";
                                                setState(() {

                                                });
                                              },
                                              child: const Text("Đã Hoàn Thành"),
                                            )
                                                :SizedBox.fromSize(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                children:orderServiceModels.service.length >1
                                    ? [
                                  const Divider(color: Colors.red,),
                                  ...orderServiceModels.service.map((singleService) {
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
                                                    singleService.image,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text( singleService.name,
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
                                                            "Trọng lượng thú cưng :${singleService.trongluong.toString()}",style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                          ),
                                                          const SizedBox(height: 12),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 12),
                                                      Text(
                                                        "Giá :${singleService.gia.toString()} VND",style: const TextStyle(
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
          ),
        )
    );
  }
  // Hàm loadding
  Future<void> _handleRefresh() async {
    setState(() {
    });
  }
}
