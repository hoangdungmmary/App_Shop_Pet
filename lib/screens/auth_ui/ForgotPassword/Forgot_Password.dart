
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
final email= TextEditingController();
  @override
  void dispose(){
    email.dispose();
    super.dispose();
  }
  Future passwordRest() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim());
      showDialog(context: context,
          builder: (context){
        return AlertDialog(
          content: Text("Đã gửi link đến gmail để đặt lại mật khẩu"),
        );
          });
    }on FirebaseAuthException catch(e){
      print(e);
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Nhập Gmail và nhập mật khẩu mới trong đường link"),
          ),
          SizedBox(height: 12,),
          TextFormField(

            controller: email,
            decoration: InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(Icons.email,
                color: Color(0xFF64B5F6),
                size: 30.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: const TextStyle(fontSize: 16),
          ),
          SizedBox(height: 12,),
          MaterialButton(
            onPressed: passwordRest,
            color: Colors.blue[400],
            child: Text(" Đặt lại mật khẩu"),
          ),
        ],
      ),
    );
  }
}
