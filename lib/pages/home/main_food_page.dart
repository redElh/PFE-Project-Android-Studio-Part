import 'package:first_project/utils/dimensions.dart';
import 'package:first_project/widgets/big_text.dart';
import 'package:first_project/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void>_loadResources()async{
    await Get.find<PopularProdsController>().getPopularProductList();
    await Get.find<RecommendedProdsController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    print("Current height is ${MediaQuery.of(context).size.height}");
    return RefreshIndicator(
        child: Column(
          children: [
            //Showing the header
            Container(
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height45,
                    bottom: Dimensions.height15),
                padding: EdgeInsets.only(left: Dimensions.width20,
                    right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(text: "Morocco",color: const Color(0xFF89dad0)),
                        Row(
                          children: [
                            SmallText(text: "Essaouira",color: const Color(0xFF332d2b)),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        )
                      ],
                    ),
                    Center(
                      child:Container(
                        width: Dimensions.height10*6,
                        height: Dimensions.height10*6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),

                        ),
                        child: Image.asset(
                          'assets/image/splash.png', // Path to your search icon image

                          fit: BoxFit.cover,
                          width: Dimensions.iconSize24,
                          height: Dimensions.iconSize24,
                        ),
                      ) ,
                    )
                  ],
                ),
              ),
            ),
            //Showing the body
            Expanded(child: SingleChildScrollView(
              child: FoodPageBody(),
            ))
          ],
        ),
        onRefresh: _loadResources
    );
  }
}