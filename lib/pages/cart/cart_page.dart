import 'package:first_project/base/no_data_page.dart';
import 'package:first_project/controllers/auth_controller.dart';
import 'package:first_project/controllers/location_controller.dart';
import 'package:first_project/controllers/popular_product_controller.dart';
import 'package:first_project/controllers/recommended_product_controller.dart';
import 'package:first_project/data/api/YourApiService.dart';
import 'package:first_project/data/api/api_client.dart';
import 'package:first_project/pages/cart/cart_history.dart';
import 'package:first_project/pages/home/main_food_page.dart';
import 'package:first_project/routes/route_helper.dart';
import 'package:first_project/utils/app_constants.dart';
import 'package:first_project/utils/dimensions.dart';
import 'package:first_project/widgets/app_icon.dart';
import 'package:first_project/widgets/big_text.dart';
import 'package:first_project/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/cart_model.dart';
import '../../models/checkoutData_model.dart';
import '../../models/products_model.dart';
import '../../models/user_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20*3,
              right: Dimensions.width20,
              left: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: Color(0xFF89dad0),
                      size: 35,
                      iconSize: 20,
                    ),
                  ),
                  SizedBox(width: Dimensions.width20*5,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: Color(0xFF89dad0),
                      size: 35,
                      iconSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(CartHistory());
                    },
                    child: AppIcon(icon: Icons.shopping_cart_outlined,
                      iconColor: Colors.white,
                      backgroundColor: Color(0xFF89dad0),
                      size: 35,
                      iconSize: 20,
                    ),
                  )
                ],
              )
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?
            Positioned(
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                top: Dimensions.height20*5,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController){
                      var _cartList=cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_,index){
                            return Container(
                              height: Dimensions.height20*5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      var popularIndex=Get.find<PopularProdsController>().
                                      popularProductList.indexOf(_cartList[index].product);

                                      if(popularIndex>=0){
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cart page"));
                                      }else{
                                        var recommendedIndex=Get.find<RecommendedProdsController>().
                                        recommendedProductList.indexOf(_cartList[index].product);

                                        if(recommendedIndex<0){
                                          Get.snackbar("History product", "Product review is not available for the history products",
                                              backgroundColor: Color(0xFF89dad0),
                                              colorText: Colors.white);
                                        }else{
                                          Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cart page"));
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: Dimensions.height20*5,
                                      height: Dimensions.height20*5,
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL
                                                      +cartController.getItems[index].img!
                                              ),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10,),
                                  Expanded(child: Container(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(
                                          text: cartController.getItems[index].name!,
                                          color: Colors.black54,
                                        ),
                                        SmallText(text: "Sweet"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text: "\$ ${cartController.getItems[index].price}",
                                              color: Colors.redAccent,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: Dimensions.height10,
                                                  bottom: Dimensions.height10,
                                                  left: Dimensions.width10,
                                                  right: Dimensions.width10
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, -1);
                                                      },
                                                      child: Icon(Icons.remove,color: Color(0xFFa9a29f),)
                                                  ),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  BigText(text: _cartList[index].quantity.toString()),//popularProduct.inCartItems.toString()),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  GestureDetector(
                                                      onTap: (){
                                                        if(_cartList[index].quantity!<10){
                                                          cartController.addItem(_cartList[index].product!, 1);
                                                        }
                                                      },
                                                      child: Icon(Icons.add,color: Color(0xFFa9a29f),)
                                                  ),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Ajoutez ici la logique pour supprimer le produit du panier
                                                      cartController.removeItem(_cartList[index].product! as ProductModel);
                                                    },
                                                    child: Icon(Icons.delete, color: Colors.red),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    }),
                  ),
                )
            ):NoDataPage(text: "Your cart is empty!");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return GetBuilder<UserController>(
            builder: (userController) {
              return GestureDetector(
                onTap: () => _checkout(cartController.getItems, userController),
                child: Container(
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
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2),
                    ),
                  ),
                  child: cartController.getItems.length > 0
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: Dimensions.width10 / 2),
                            BigText(text: "\$" + cartController.totalAmount.toString()),
                            SizedBox(width: Dimensions.width10 / 2),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _checkout(cartController.getItems, userController);
                            if(Get.find<AuthController>().userLoggedIn()){
                              print("logged in hihi");//
                              cartController.addToHistory();
                              Get.to(CartHistory());
                            }else{
                              Get.toNamed(RouteHelper.getSignInPage());
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: Dimensions.height20,
                              bottom: Dimensions.height20,
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                            ),
                            child: BigText(
                              text: "Check out",
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Color(0xFF89dad0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      : Container(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _checkout(List<CartModel> cartItems, UserController userController) async {
    final response = await userController.getUserInfo();
    YourApiService yourApiService=Get.find();

    if (response.isSuccess){
      final userModel = userController.userModel;

      // Combine user info and cart items
      final checkoutData = CheckoutDataModel(user: userModel, cartItems: cartItems);
      print(checkoutData.toJson());
      // Send combined data to the server
      /*final response = await yourApiService.postData(AppConstants.SEND_ORDER, checkoutData.toJson());

      // Handle response accordingly
      if (response.statusCode == 200) {
        // Handle success
        print("yeeeey success");
      } else {
        // Handle error
        print("yeeeey error");
      }*/
      try {
        final response = await yourApiService.postData(
            '${AppConstants.BASE_URL}${AppConstants.SEND_ORDER}',
            checkoutData.toJson()
        );

        if (response.statusCode == 200) {
          print("yeeeey success");

          Get.snackbar(
            "Success",
            "The order has been sent successfully",
            backgroundColor: Color(0xFF89dad0),
            colorText: Colors.white,
          );
        } else {
          print("Error: ${response.statusText}");
        }
      } catch (e) {
        print("Exception during API call: $e");
      }
    }else {
      // Handle error getting user info
      print("error getting user info");
    }
  }


}