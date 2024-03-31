import 'package:first_project/controllers/popular_product_controller.dart';
import 'package:first_project/controllers/recommended_product_controller.dart';
import 'package:first_project/pages/cart/cart_page.dart';
import 'package:first_project/routes/route_helper.dart';
import 'package:first_project/utils/dimensions.dart';
import 'package:first_project/widgets/app_icon.dart';
import 'package:first_project/widgets/expandable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/app_constants.dart';
import '../../widgets/big_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  RecommendedFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<RecommendedProdsController>().recommendedProductList[pageId];
    Get.find<PopularProdsController>().initProduct(product,
        Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
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
                  child:AppIcon(icon: Icons.clear),
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
                      Get.find<PopularProdsController>().totalItems>=1?
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
                })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Container(
                child: Center(child: BigText(size:Dimensions.font26,text:product.name),),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20)
                    )
                ),
              ),

            ),
            pinned: true,
            backgroundColor: Color(0xffffa809),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),

          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text:product.description!),
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProdsController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                  left: Dimensions.width20*2.5,
                  right: Dimensions.width20*2.5
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(icon: Icons.remove,backgroundColor: Color(0xFF89dad0),
                      iconColor:Colors.white,
                      iconSize: Dimensions.iconSize24,),
                  ),
                  BigText(text: "\$${product.price} "+" X "+" ${controller.inCartItems} ",color: Color(0xFF332d2b),
                    size: Dimensions.font26,),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcon(icon: Icons.add,backgroundColor: Color(0xFF89dad0),
                        iconColor:Colors.white,
                        iconSize: Dimensions.iconSize24),
                  )
                ],
              ),
            ),
            Container(
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
                      child: Icon( Icons.favorite,
                        color:Color(0xFF89dad0) ,)
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20
                      ),
                      child: BigText(text: "\$${product.price*controller.inCartItems} | Add to cart",color: Colors.white,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Color(0xFF89dad0)
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
