import 'package:first_project/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height20*5,
        width: Dimensions.height20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20*5/2),
          color: Color(0xff89dad0)
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
