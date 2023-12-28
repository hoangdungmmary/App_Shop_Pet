
import 'package:app_pet_shop/constants/routes.dart';
import 'package:app_pet_shop/models/Service_Models/Service_Models.dart';
import 'package:app_pet_shop/provider/app_provider.dart';
import 'package:app_pet_shop/screens/Servive_Screen/Service_Screen.dart';
import 'package:app_pet_shop/screens/cart_screen/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../checkout_servce/checkout_servce.dart';

class ServiceDetails extends StatefulWidget {
  final ServiceModels singleService;
  const ServiceDetails({super.key, required this.singleService, });

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  int trongluong =1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.push(
            context,

            MaterialPageRoute(
              builder: (context) =>const ServiceScreen(),
            ),
          ),
          child: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        actions: [
          IconButton(onPressed: (){
            Routes.instance.push(widget: const CartScreen(), context: context);
          },
              icon: const Icon(Icons.shopping_cart))
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
              Image.network(widget.singleService.image,
                height: 300,
                width: 300,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.singleService.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(onPressed: (){
                      setState(() {
                        widget.singleService.fav =!widget.singleService.fav;
                      });
                      if(   widget.singleService.fav){
                        appProvider.addfavouriteService( widget.singleService);
                      }else
                      {
                        appProvider.removefavouriteService( widget.singleService);
                      }
                    },
                      icon: Icon( appProvider.getfavouriteServiceList.contains( widget.singleService)
                          ?Icons.favorite
                          :Icons.favorite_border,size: 30,color: Colors.red,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12,),
              Text(
                "Giá :  ${widget.singleService.gia.toString()} VND",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12,),
              Text(widget.singleService.desc,style: const TextStyle(
                fontSize: 20,
              ),),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(right: 160),
                child: const Text("Trọng lượng thú cưng",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: (){
                      setState(() {
                        if(trongluong>=1){
                          setState(() {
                            trongluong--;
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
                  Text(trongluong.toString(),style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                  const SizedBox(height: 12),
                  CupertinoButton(
                    onPressed: (){
                      setState(() {
                        trongluong++;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),

                  ),
                  const SizedBox(height: 12),
                  Text("KG",style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                ],
              ),
              SizedBox(
                height: 50,
                width: 190,
                child: ElevatedButton(
                  onPressed: (){
                    ServiceModels serviceModels = widget.singleService.copyWith(trongluong: trongluong);
                    Routes.instance.push(widget: CheckOutService(singleServicec:serviceModels), context: context);
                  },
                  child: const Text("Đăng ký lịch hẹn"),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
