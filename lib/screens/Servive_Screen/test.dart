//
// import 'package:app_pet_shop/models/traningpet/traning_models.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:app_pet_shop/constants/colors.dart' as color;
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'dart:convert';
//
// import '../../firebase_helper/frebase_firestore/firebase_firestore.dart';
// import '../../provider/app_provider.dart';
//
// class TraningScreen extends StatefulWidget {
//   const TraningScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TraningScreen> createState() => _TraningScreenState();
// }
//
// class _TraningScreenState extends State<TraningScreen> {
//   List<TranningModels> tranningList =[];
//
//   bool isLoading = false;
//   @override
//   void initState() {
//     AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
//     appProvider.getUserInfoFirebase();
//     getTranning();
//     super.initState();
//   }
//
//
//   void getTranning() async{
//     setState(() {
//       isLoading = true;
//     });
//     tranningList =  await FirebaseFirestoreHelper.instance.getTranning();
//     setState(() {
//       isLoading = false;
//     });
//
//   }
// //   List info =[];
// // _initData(){
// //   DefaultAssetBundle.of(context).loadString("assets/json/info.json").then((value){
// //    info=json.decode(value);
// //   });
// // }
// //   @override
// //   void initState(){
// //     super.initState();
// //     _initData();
// //   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: color.AppColors.homePageBackground,
//       body:  Container(
//         padding: const EdgeInsets.only(top :70,left: 30,right: 30),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.arrow_back_ios,
//                   size: 20,
//                   color: color.AppColors.homePageIcon,),
//                 Expanded(child:Container()),
//                 Text(
//                   "Huấn Luyện",
//                   style: TextStyle(
//                     fontSize: 35,
//                     color: color.AppColors.homePageTitle,
//                     fontWeight: FontWeight.w700,
//
//                   ),
//                 ),
//                 //
//                 //
//               ],
//             ),
//             SizedBox(height: 30,),
//             Row(
//               children: [
//                 Text(
//                   "Chương trình nổi bật",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: color.AppColors.homePageSutitle,
//                     fontWeight: FontWeight.w700,
//
//                   ),
//                 ),
//                 Expanded(child: Container()),
//                 Text(
//                   "Chi tiết",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: color.AppColors.homePageDetail,
//                     fontWeight: FontWeight.w700,
//
//                   ),
//                 ),
//                 Icon(Icons.arrow_forward,
//                   size: 20,
//                   color: color.AppColors.homePageIcon,)
//               ],
//             ),
//             SizedBox(height: 20,),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 220,
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors:[
//                         color.AppColors.gradientFirst.withOpacity(0.8),
//                         color.AppColors.gradientSecond.withOpacity(0.9),
//                       ],
//                       begin: Alignment.bottomLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       bottomLeft: Radius.circular(10),
//                       bottomRight: Radius.circular(10),
//                       topRight: Radius.circular(80),
//
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         offset: Offset(5,10),
//                         blurRadius: 20,
//                         color: color.AppColors.gradientSecond.withOpacity(0.2),
//
//                       ),
//                     ]
//                 ),
//                 child: Container(
//                   padding: const EdgeInsets.only(left: 20,top: 25,right: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(" Các bài hướng dẫn",
//                         style: TextStyle(
//                           fontSize: 17,
//                           color: color.AppColors.homePageContainerTextSmall,
//
//                         ),),
//                       SizedBox(height: 5,),
//                       Text("Hữu ích",
//                         style: TextStyle(
//                           fontSize: 25,
//                           color: color.AppColors.homePageContainerTextSmall,
//
//                         ),),
//                       SizedBox(height: 5,),
//                       Text("Và vô cùng sinh dộng ",
//                         style: TextStyle(
//                           fontSize: 25,
//                           color: color.AppColors.homePageContainerTextSmall,
//                         ),),
//                       SizedBox(height: 25,),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Row(
//
//                             children: [
//                               Icon(Icons.timer,size: 20,color: color.AppColors.homePageContainerTextSmall,),
//                               SizedBox(height: 10,),
//                               Text("3 min",
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: color.AppColors.homePageContainerTextSmall,
//                                 ),),
//
//                             ],
//                           ),
//                           Expanded(child: Container()),
//                           Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(60),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: color.AppColors.gradientFirst,
//                                     blurRadius: 10,
//                                     offset: Offset(4,8),
//                                   )
//                                 ]
//                             ),
//                             child: Icon(
//                               Icons.play_circle_fill,
//                               color: Colors.white, size: 60,
//
//                             ),
//                           )
//                         ],
//                       ),
//
//
//                     ],
//                   ),
//                 )
//             ),
//             SizedBox(height: 5,),
//             Container(
//               height: 180,
//               width: MediaQuery.of(context).size.width,
//               child:Stack(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     margin: const EdgeInsets.only(top:30),
//                     height: 120,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         image: DecorationImage(
//                           image :AssetImage(
//                               "assets/images/banner.png"
//                           ),
//                           fit: BoxFit.fill,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 40,
//                             offset: Offset(8,10),
//                             color: color.AppColors.gradientSecond.withOpacity(0.3),
//
//                           ),
//                           BoxShadow(
//                             blurRadius: 10,
//                             offset: Offset(-8,-6),
//                             color: color.AppColors.gradientSecond.withOpacity(0.3),
//
//                           )
//                         ]
//                     ),
//                   ),
//                   Container(
//                     height: 200,
//                     width: MediaQuery.of(context).size.width,
//                     margin: const EdgeInsets.only(right: 185, bottom: 60,top: 20),
//                     decoration: BoxDecoration(
//                       // color: Colors.redAccent.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(20),
//                       image: DecorationImage(
//                         image :AssetImage(
//                             "assets/images/iconpet.png"
//                         ),
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: double.maxFinite,
//                     height: 100,
//                     //  color:Colors.redAccent.withOpacity(0.2),
//                     margin: const EdgeInsets.only(left: 150,top: 50),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Thú cưng luyện tập",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: color.AppColors.homePageDetail,
//
//                           ),),
//                         SizedBox(height: 10,),
//                         RichText(text: TextSpan(
//                             text: "Luyện tập mỗi ngày\n",
//                             style: TextStyle(
//                               color: color.AppColors.homePagePlanColor,
//                               fontSize: 12,
//                             ),
//                             children: [
//                               TextSpan(
//                                 text: "Thú cưng ngoan ngoãn, nghe lời",
//
//                               )
//                             ]
//                         ))
//                       ],
//                     ),
//                   ),
//
//                 ],
//               ) ,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Các Video hướng dẫn",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w500,
//                     color: color.AppColors.homePageTitle,
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: 20,),
//             Expanded(
//               child:       tranningList.isEmpty
//                   ?Center(child: Text("Dịch vụ trống"),)
//                   :
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children:  tranningList.map(
//                         (e)=> Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: CupertinoButton(
//                         padding: EdgeInsets.zero,
//                         onPressed: (){
//                           //   Routes.instance.push(widget: CategoryServiceView(categoryServiceModels: e), context: context);
//                         },
//                         child: Card(
//                           color: Colors.white,
//                           elevation: 3.0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                           child:Column(
//                             children: [
//                               SizedBox(
//                                 height: 100,
//                                 width: 100,
//                                 child:Image.network(e.image),
//                               ),
//                               Text(e.name,style: TextStyle(
//                                   fontWeight: FontWeight.bold
//                               ),)
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ).toList(),
//                 ),
//               ),
//               child: OverflowBox(
//                 maxWidth: MediaQuery.of(context).size.width,
//                 child: MediaQuery.removePadding(
//                   removeTop: true,
//                   context: context,
//                   child: ListView.builder(
//                     itemCount: (tranningList.length.toDouble()/2).toInt(),
//                     itemBuilder: (_,i){
//                       int a = 2*i;
//                       int b = 2*i +1;
//                       return Row(
//                         children: [
//                           Container(
//                             width: (MediaQuery.of(context).size.width-90)/2,
//                             height: 170,
//                             margin:EdgeInsets.only(left: 30,bottom: 15,top: 15),
//                             padding: EdgeInsets.only(bottom: 5),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius:  BorderRadius.circular(15),
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         info[a]['img']
//                                     )
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     blurRadius: 3,
//                                     offset: Offset(5,5),
//                                     color:color.AppColors.gradientSecond.withOpacity(0.1),
//
//                                   ),
//                                   BoxShadow(
//                                     blurRadius: 3,
//                                     offset: Offset(-5,-5),
//                                     color:color.AppColors.gradientSecond.withOpacity(0.1),
//
//                                   )
//                                 ]
//                             ),
//                             child: Center(
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Text(
//                                   info[a]["title"],
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: color.AppColors.homePageDetail,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: (MediaQuery.of(context).size.width-90)/2,
//                             height: 170,
//                             margin:EdgeInsets.only(left: 30,bottom: 15,top: 15),
//                             padding: EdgeInsets.only(bottom: 5),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius:  BorderRadius.circular(15),
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         info[b]['img']
//                                     )
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     blurRadius: 3,
//                                     offset: Offset(5,5),
//                                     color:color.AppColors.gradientSecond.withOpacity(0.1),
//
//                                   ),
//                                   BoxShadow(
//                                     blurRadius: 3,
//                                     offset: Offset(-5,-5),
//                                     color:color.AppColors.gradientSecond.withOpacity(0.1),
//
//                                   )
//                                 ]
//                             ),
//                             child: Center(
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Text(
//                                   info[b]["title"],
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: color.AppColors.homePageDetail,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30,)
//           ],
//         ),
//       ),
//
//     );
//   }
// }
