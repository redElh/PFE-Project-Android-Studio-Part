import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscured;
  AppTextField({super.key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isObscured=false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.screenHeight/14,
      margin: EdgeInsets.only(left: Dimensions.height20,right:Dimensions.height20 ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: Offset(1,10),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        obscureText: isObscured?true:false,
        controller: textController,
        decoration: InputDecoration(
          //hintText
            hintText: hintText,
            //prefixIcon
            prefixIcon: Icon(icon,color: Color(0xFFffd379),),
            //focusedBorder
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                borderSide: BorderSide(
                    width: 1.0,
                    color:Colors.white
                )
            ),
            //enabledBorder
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                borderSide: BorderSide(
                    width: 1.0,
                    color:Colors.white
                )
            ),
            //border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
            )
        ),
      ),
    );
  }
}
