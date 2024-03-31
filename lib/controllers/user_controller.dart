import 'package:first_project/models/user_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/repository/user_repo.dart';
import '../models/response_model.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo
  });

  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  late UserModel _userModel;
  UserModel get userModel=>_userModel;

  Future<ResponseModel> getUserInfo()async{
    update();
    Response response=await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if(response.statusCode==200){
       print("hiiii!");
      _userModel=UserModel.fromJson(response.body);
      print(response.body);
       _isLoading=true;
      responseModel=ResponseModel(true, "successfully");
    }else{
      print("Oppps");
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      responseModel=ResponseModel(false, response.statusText!);
    }
    _isLoading=true;
    update();
    return responseModel;
  }
}