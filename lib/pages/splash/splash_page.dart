import 'dart:async';

import 'package:first_project/routes/route_helper.dart';
import 'package:first_project/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen>with TickerProviderStateMixin {
  late Animation<double>animation;
  late AnimationController controller;

  Future<void>_loadResources()async{
    await Get.find<PopularProdsController>().getPopularProductList();
    await Get.find<RecommendedProdsController>().getRecommendedProductList();
  }

  @override
  void initState(){
    super.initState();
    _loadResources();
    controller=new AnimationController(vsync: this,duration: Duration(seconds: 2))..forward();
    animation=new CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
        const Duration(
          seconds: 3,
        ),
            ()=>Get.offNamed(RouteHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child:Image.asset("assets/image/splash.png",width: Dimensions.splashImg,),
            ),
          ),
          Center(
            child:Image.asset("assets/image/TBF.png",width: Dimensions.splashImg,),
          ),
        ],
      ),
    );
  }
}
