
import 'package:app_pet_shop/screens/favourite_screen/single_favourite_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import 'single_favourite_screen.dart';

class FavouriteServiceScreen extends StatelessWidget {
  const FavouriteServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvder = Provider.of<AppProvider>(
      context,);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dịch vụ yêu thích",
          style: TextStyle(
            color: Colors.black,
          ),),
      ),
      body: appProvder.getfavouriteServiceList.isEmpty?const Center(child: Text("Không có dịch vụ yêu thích"),): ListView.builder(
        itemCount: appProvder.getfavouriteServiceList.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (ctx,index){
          return SingleFavoriteServiceItem(
            singleService: appProvder.getfavouriteServiceList[index],
          );
        },

      ),
    );
  }
}
