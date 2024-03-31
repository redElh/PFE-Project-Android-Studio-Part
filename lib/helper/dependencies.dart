import 'package:first_project/controllers/auth_controller.dart';
import 'package:first_project/controllers/cart_controller.dart';
import 'package:first_project/controllers/location_controller.dart';
import 'package:first_project/controllers/popular_product_controller.dart';
import 'package:first_project/controllers/user_controller.dart';
import 'package:first_project/data/api/api_client.dart';
import 'package:first_project/data/repository/auth_repo.dart';
import 'package:first_project/data/repository/cart_repo.dart';
import 'package:first_project/data/repository/location_repo.dart';
import 'package:first_project/data/repository/popular_product_repo.dart';
import 'package:first_project/data/repository/user_repo.dart';
import 'package:first_project/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/api/YourApiService.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void>init() async{
  final sharedPreferences=await SharedPreferences.getInstance();

  Get.lazyPut(()=>sharedPreferences);
  //Api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL,sharedPreferences:Get.find()));
  Get.lazyPut(()=>AuthRepo(apiClient:Get.find(), sharedPreferences:Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(()=>YourApiService());

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
  Get.lazyPut(()=>LocationRepo(apiClient:Get.find(), sharedPreferences:Get.find()));

  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProdsController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProdsController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
}