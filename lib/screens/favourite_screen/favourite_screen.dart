
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import 'single_favourite_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvder = Provider.of<AppProvider>(
      context,);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sản phẩm yêu thích",
          style: TextStyle(
            color: Colors.black,
          ),),
      ),
      body: appProvder.getfavouriteProductList.isEmpty?const Center(child: Text("Không có sản phẩm yêu thích"),): ListView.builder(
        itemCount: appProvder.getfavouriteProductList.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (ctx,index){
          return SingleFavoriteItem(
            singleProduct: appProvder.getfavouriteProductList[index],
          );
        },

      ),
    );
  }
}
