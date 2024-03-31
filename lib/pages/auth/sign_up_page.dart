import 'package:first_project/base/custom_loader.dart';
import 'package:first_project/base/show_custom_snackbar.dart';
import 'package:first_project/controllers/auth_controller.dart';
import 'package:first_project/models/signup_body_model.dart';
import 'package:first_project/pages/auth/sign_in_page.dart';
import 'package:first_project/routes/route_helper.dart';
import 'package:first_project/widgets/app_text_field.dart';
import 'package:first_project/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var phoneController=TextEditingController();

    var signUpImages=[
      "f.png",
      "g.png",
      "t.png"
    ];

    void _registration(AuthController authController){
      String name=nameController.text.trim();
      String phone=phoneController.text.trim();
      String email=emailController.text.trim();
      String password=passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Type in your name",title:"Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number",title:"Phone number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email address",title:"Email address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address",title:"Valid email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title:"Password");
      }else if(password.length<6){
        showCustomSnackBar("Password cannot be less than six characters",title:"Password");
      }else{
        showCustomSnackBar("All went well",title:"Perfect");
        SignUpBody signUpBody=SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password
        );
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success registration");
            Get.offNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
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
                  isObscured: true,
              ),
              SizedBox(height: Dimensions.height20,),
              //your name
              AppTextField(
                  textController: nameController,
                  hintText: "Name",
                  icon: Icons.person
              ),
              SizedBox(height: Dimensions.height20,),
              //your phone
              AppTextField(
                  textController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone
              ),
              SizedBox(height: Dimensions.height20*2,),
              //sign up button
              GestureDetector(
                onTap: (){
                  _registration(_authController);
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
                      text: "Sign up",
                      size: Dimensions.font20*1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              //tag line
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignInPage()),
                      text: "Have an account already?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      )
                  )
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign up options
              RichText(
                  text: TextSpan(
                      text: "Sign up using one of the following methods",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16
                      )
                  )
              ),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      "assets/image/"+signUpImages[index],
                    ),
                  ),
                )),
              )
            ],
          ),
        )
        :const CustomLoader();
      }),
    );
  }
}
