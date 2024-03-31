import 'package:first_project/base/custom_loader.dart';
import 'package:first_project/controllers/auth_controller.dart';
import 'package:first_project/controllers/cart_controller.dart';
import 'package:first_project/controllers/user_controller.dart';
import 'package:first_project/routes/route_helper.dart';
import 'package:first_project/widgets/account_widget.dart';
import 'package:first_project/widgets/app_icon.dart';
import 'package:first_project/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/dimensions.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoogedIn=Get.find<AuthController>().userLoggedIn();
    print(_userLoogedIn);
    if(_userLoogedIn){
      print(Get.find<UserController>().getUserInfo());
    }
    return Scaffold(
      //backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 0),
        children: [
          Container(
            height: Dimensions.height20 * 4.5,
            decoration: BoxDecoration(
              color: Color(0xFF89dad0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Profile",
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
          ),
          GetBuilder<UserController>(builder: (userController){
            return _userLoogedIn?
                  (userController.isLoading?Container(
              padding: EdgeInsets.only(top: Dimensions.height20),
              child: Column(
                children: [
                  AppIcon(
                    icon: Icons.person,
                    backgroundColor: Color(0xFF89dad0),
                    iconSize: Dimensions.height15 * 5,
                    iconColor: Colors.white,
                    size: Dimensions.height15 * 10,
                  ),
                  SizedBox(height: Dimensions.height30),
                  AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.person,
                      backgroundColor: Color(0xFFffd379),
                      iconSize: Dimensions.height10 * 5 / 2,
                      iconColor: Colors.white,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText: BigText(
                       //text: "Rida",
                      text: userController.userModel.name,
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.phone,
                      backgroundColor: Color(0xFFffd379),
                      iconSize: Dimensions.height10 * 5 / 2,
                      iconColor: Colors.white,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText: BigText(
                      // text: "11223355",
                       text: userController.userModel.phone,
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.email,
                      backgroundColor: Color(0xFFffd379),
                      iconSize: Dimensions.height10 * 5 / 2,
                      iconColor: Colors.white,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText: BigText(
                      // text:"redaelhiri9@gmail.com" ,
                       text: userController.userModel.email,
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.location_on,
                      backgroundColor: Color(0xFFffd379),
                      iconSize: Dimensions.height10 * 5 / 2,
                      iconColor: Colors.white,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText: BigText(
                      text: "Fill in your address",
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.message_outlined,
                      backgroundColor: Colors.redAccent,
                      iconSize: Dimensions.height10 * 5 / 2,
                      iconColor: Colors.white,
                      size: Dimensions.height10 * 5,
                    ),
                    bigText: BigText(
                      text: "Messages",
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  GestureDetector(
                    onTap: (){
                      if(Get.find<AuthController>().userLoggedIn()){
                        Get.find<AuthController>().clearSharedData();
                        Get.find<CartController>().clear();
                        Get.find<CartController>().clearCartHistory();
                        Get.offNamed(RouteHelper.getSignInPage());
                      }else{
                        print("You logged out");
                      }
                    },
                    child: AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.logout,
                        backgroundColor: Colors.redAccent,
                        iconSize: Dimensions.height10 * 5 / 2,
                        iconColor: Colors.white,
                        size: Dimensions.height10 * 5,
                      ),
                      bigText: BigText(
                        text: "Logout",
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                ],
              ),
            ):CustomLoader())
                  :Container(child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height20*18,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20
                        ),//
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            image:DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/image/signInToContinue.png"
                                )
                            )
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.getSignInPage());
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.height20*5,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFF89dad0),
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Center(child: BigText(text:"Sign in",color:Colors.white,size: Dimensions.font26,)),
                        ),
                      )
                    ],
                  )),);
          }),
        ],
      ),
    );
  }
}
