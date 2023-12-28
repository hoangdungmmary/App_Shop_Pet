

import 'package:app_pet_shop/firebase_helper/frebase_firestore/firebase_firestore.dart';
import 'package:app_pet_shop/models/Service_Models/Service_Models.dart';
import 'package:app_pet_shop/models/product_models/product_models.dart';
import 'package:app_pet_shop/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../provider/app_provider.dart';
import '../Servive_Screen/Service_Screen.dart';
import '../custom_bottom_bar/custom_bottom_bar.dart';

class CheckOutService extends StatefulWidget {
  final ServiceModels singleServicec;
  const CheckOutService({super.key, required this.singleServicec,});

  @override
  State<CheckOutService> createState() => _CheckOutServiceState();

}

TextEditingController _dateControler  = TextEditingController();
TextEditingController _timeControler  = TextEditingController();

class _CheckOutServiceState extends State<CheckOutService> {

  @override

  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Đặt lịch Dịch vụ ",
            style: TextStyle(
              color: Colors.black,
            ),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SingleChildScrollView (
            child: Column(
                  children: [
                   Padding(padding: EdgeInsets.all(12),
                     child: Container(
                         width: 250, // do it in both Container
                       child: TextField(
                         controller: _dateControler,
                         decoration:InputDecoration(
                           labelText: "Ngày",
                           filled: true,
                           prefixIcon: Icon(Icons.calendar_today),
                           enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide.none
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.pinkAccent)
                           )
                         ) ,
                         onTap: () async{
                           DateTime? _picker = await showDatePicker(
                             context: context,
                             initialDate: DateTime.now(),
                             firstDate: DateTime(2000),
                             lastDate: DateTime(2100),

                           );
                           if (_picker != null) {
                             setState(() {
                               _dateControler.text =
                                   DateFormat('dd/MM/yyyy').format(_picker);
                             });
                           }

                         },
                         readOnly: true,
                       ),
                     ),
                   ),
                    Padding(padding: EdgeInsets.all(12),
                      child: Container(
                        width: 250, // do it in both Container
                        child: TextField(
                          controller: _timeControler,
                          decoration:InputDecoration(
                              labelText: "Giờ",
                              filled: true,
                              prefixIcon: Icon(Icons.calendar_today),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.pinkAccent)
                              )
                          ) ,
                          onTap: () async{
                            TimeOfDay? _timepicker = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                            );
                            if (_timepicker != null) {
                              setState(() {
                                _timeControler.text = _timepicker.format(context);
                              });
                            }

                          },
                          readOnly: true,
                        ),
                      ),
                    ),
                  ],
                ),
          ),

            const SizedBox(height: 24),
            PrimaryButton(
              title: "Tiếp tục",
              onPressed: () async {
                appProvider.clearBuyService();
                appProvider.addBuyService(widget.singleServicec);

                bool value = await FirebaseFirestoreHelper.instance
                    .uploadOrderServiceFirebase(appProvider.getBuyServiceList,
                    context,_dateControler.text,_timeControler.text);
                if(value){
                  Future.delayed(const Duration(seconds: 2),(){
                    Routes.instance.push(widget: ServiceScreen(), context:context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

