import 'package:first_project/base/custom_loader.dart';
import 'package:first_project/pages/auth/sign_up_page.dart';
import 'package:first_project/routes/route_helper.dart';
import 'package:first_project/widgets/app_text_field.dart';
import 'package:first_project/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';
import '../../utils/dimensions.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();

    void _login(AuthController authController){
      String email=emailController.text.trim();
      String password=passwordController.text.trim();

      if(email.isEmpty){
        showCustomSnackBar("Type in your email address",title:"Email address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address",title:"Valid email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title:"Password");
      }else if(password.length<6){
        showCustomSnackBar("Password cannot be less than six characters",title:"Password");
      }else{
        authController.login(email,password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getCartPage());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading? SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/image/splash.png"
                    ),
                  ),
                ),
              ),
              //welcome
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20*3+Dimensions.font20/2,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: Colors.grey[500]
                        //fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              //your email
              AppTextField(
                  textController: emailController,
                  hintText: "Email",
                  icon: Icons.email
              ),
              SizedBox(height: Dimensions.height20,),
              //your password
              AppTextField(
                  textController: passwordController,
                  hintText: "Password",
                  icon: Icons.password_sharp,
                  isObscured:true
              ),
              SizedBox(height: Dimensions.height20,),
              //tag line
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20
                          )
                      )
                  ),
                  SizedBox(width: Dimensions.width20,)
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign in
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: Color(0xff89dad0)
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      size: Dimensions.font20*1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign up options
              RichText(
                  text: TextSpan(
                      text: "Don\'t have an account?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                            text: " Create",
                            style: TextStyle(
                              color: Color(0xFF332d2b),
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.bold,
                            )
                        )
                      ]
                  )
              ),
            ],
          ),
        ):CustomLoader();
      }),
    );
  }
}
