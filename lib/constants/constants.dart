
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message){
      Fluttertoast.showToast(
          msg: message,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
}
showLoaderDialog(BuildContext context){
      AlertDialog alert = AlertDialog(
           content: Builder(builder: (context){
                 return SizedBox(
                       width: 100,
                       child: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                                   const CircularProgressIndicator(
                                         color: Color(0xffe15555),
                                   ),
                                   const SizedBox(height: 18),
                                   Container(
                                         margin: const EdgeInsets.only(left: 7),
                                         child: const Text("Loading.."),
                                   ),

                             ],
                       ),
                 );
           }

           ),
      );
      showDialog(
        barrierDismissible: false,
            context: context,
            builder:(BuildContext content){
              return alert;
            }
      );
}
String getMessageFromErrorCode(String errorCode){
      switch(errorCode){
            case "ERRO_EMAIL_ALREDY_IN_USE":
                  return " Email đã sử dụng.Bạn có thể đến trang đăng Nhập";
            case "account-exists-with-different-creadential":
                  return "Email này đã được sử dụng. Bạn có thể trang đăng nhập";
            case "email-already-in-use":
                  return "Sử dụng email này. Bạn có thể đến trang đăng nhập";
            case "ERROR_WRONG_PASSWORD":
            case "wrong-password":
                  return "Sai mật khẩu";
            case "ERROR_USER_NOT_FOUND":
                  return "Không tìm thấy người dùng với Email này";
            case "user_not_found":
                  return"Không tìm thấy người dùng với email này";
            case "ERROR_USER_DISABLED":
                  return "Người dùng không hợp lệ";
            case "user_disable":
                  return " Người dùng không hợp lệ";
            case "ERROR_TOO_MANY_REQUESTS":
                  return "Yêu cầu đăng nhập nhiều lần";
            case "operation-not-allowed":
                  return "Yêu cầu đăng nhập nhiều lần";
            case "ERROR_OPERATION_NOT_ALLOWED":
                  return "Yêu cầu đăng nhập nhiều lần";
            case "ERROR_INVALID_EMAIL":
                  return "Email không phù hợp";
            case "invalid-email":
                  return "Email không phù hợp";
            default :
                  return "Đăng nhập không thành công";


      }

}

bool loginVaildation (String email,String password){
      if(email.isEmpty && password.isEmpty){
            showMessage("Email và Password còn trống");
            return false;
      }
      else if(email.isEmpty){
            showMessage("Email Trống");
            return false;
      } else if(password.isEmpty){
            showMessage("Mật khẩu còn Trống");
            return false;
      }
      else{
            return true;
      }

}

bool signupVaildation (String email,String password,String name, String phone, String Diachi){
      if(email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty){
            showMessage("Tất cả còn trống");
            return false;
      }
      else if(email.isEmpty){
            showMessage("Email Trống");
            return false;
      }
      else if(name.isEmpty){
            showMessage("Tên Trống");
            return false;
      }
      else if(phone.isEmpty){
            showMessage("Số điện thoại Trống");
            return false;
      }
     else if(password.isEmpty){
            showMessage("Mật khẩu còn Trống");
            return false;
      }
      else if(Diachi.isEmpty){
            showMessage("Địa chỉ còn Trống");
            return false;
      }
      else{
            return true;
      }

}
