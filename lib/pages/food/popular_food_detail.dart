import 'package:first_project/controllers/cart_controller.dart';
import 'package:first_project/controllers/popular_product_controller.dart';
import 'package:first_project/pages/cart/cart_page.dart';
import 'package:first_project/pages/home/main_food_page.dart';
import 'package:first_project/utils/app_constants.dart';
import 'package:first_project/utils/dimensions.dart';
import 'package:first_project/widgets/app_column.dart';
import 'package:first_project/widgets/app_icon.dart';
import 'package:first_project/widgets/expandable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/route_helper.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widgets.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  PopularFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<PopularProdsController>().popularProductList[pageId];
    Get.find<PopularProdsController>().initProduct(product,
        Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,//take all the available width
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                      ),
                    )
                ),
              )),
          //icon widgets
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(page=="cart page"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios),
                  ),
                  GetBuilder<PopularProdsController>(builder: (controller){
                    return Stack(
                      children: [
                        GestureDetector(
                            onTap: (){
                              //if(controller.totalItems>=1){
                                Get.toNamed(RouteHelper.getCartPage());
                              //}
                            },
                            child: AppIcon(icon: Icons.shopping_cart_outlined)
                        ),
                        controller.totalItems>=1?
                        Positioned(
                          right: 0,
                          top: 0,
                          child: AppIcon(icon: Icons.circle,size: 20,backgroundColor:
                          Color(0xFF89dad0),iconColor: Colors.transparent,),
                        )
                            :Container(),
                        Get.find<PopularProdsController>().totalItems>=1?
                        Positioned(
                          right: 6,
                          top: 2,
                          child: BigText(
                            text: Get.find<PopularProdsController>().totalItems.toString(),
                            size: 12,
                            color: Colors.white,
                          ),
                        )
                            :Container(),
                      ],
                    );
                  }),
                ],
              )
          ),
          //introduction of food
          Positioned(
              left: 0,
              right: 0,
              top: Dimensions.popularFoodImgSize-60,
              bottom: 0,
              child:Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.width20
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20)
                    ),
                    color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height10,),
                    Expanded(
                        child:SingleChildScrollView(
                          child: ExpandableTextWidget(text: product.description),
                        )
                    )
                  ],
                ),
              )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProdsController>(
        builder: (popularProduct){
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            decoration: BoxDecoration(
                color: Color(0xFFf7f6f4),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2)
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(Icons.remove,color: Color(0xFFa9a29f),)
                      ),
                      SizedBox(width: Dimensions.width10/2,),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(width: Dimensions.width10/2,),
                      GestureDetector(
                          onTap: (){
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(Icons.add,color: Color(0xFFa9a29f),)
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    popularProduct.addItem(product);
                  } ,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20
                    ),
                    child: BigText(
                      text: "\$${product.price*popularProduct.inCartItems}"
                          " | Add to cart",color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Color(0xFF89dad0)
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
