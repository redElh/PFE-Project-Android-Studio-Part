
import 'package:first_project/controllers/cart_controller.dart';
import 'package:first_project/controllers/popular_product_controller.dart';
import 'package:first_project/pages/auth/sign_in_page.dart';
import 'package:first_project/pages/auth/sign_up_page.dart';
import 'package:first_project/pages/food/popular_food_detail.dart';
import 'package:first_project/pages/food/recommended_food_detail.dart';
import 'package:first_project/pages/home/food_page_body.dart';
import 'package:first_project/pages/home/main_food_page.dart';
import 'package:first_project/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

void main()async {
  //make sure that your deps are loaded correctly and wait until they're loaded
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  await Get.find<PopularProdsController>().getPopularProductList();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProdsController>(builder: (_){
      return GetBuilder<RecommendedProdsController>(builder:(_){
        return  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          //home: SignInPage(),
          //home: SplashScreen(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}

