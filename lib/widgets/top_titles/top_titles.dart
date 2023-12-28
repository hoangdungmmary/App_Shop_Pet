
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopTitles  extends StatelessWidget {
  final String title;
  final String subtitles;
  const TopTitles ({super.key, required this.title, required this.subtitles});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        if(title=="Đăng nhập" || title=="Tạo tài khoản")
          GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          SizedBox(height: 12),
        Center(
          child: Text(title,
          style: TextStyle(
          color: Color(0xFF1E88E5),
          fontWeight: FontWeight.bold,
          fontSize: 30.0,

          ),),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(subtitles,
            style: TextStyle(
              color: Color(0xFF1E88E5),
              fontWeight: FontWeight.bold,
              fontSize: 18.0,

            ),),
        ),
      ],
    );
  }
}
