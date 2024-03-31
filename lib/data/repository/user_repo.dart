import 'package:first_project/data/api/api_client.dart';
import 'package:first_project/data/repository/auth_repo.dart';
import 'package:first_project/utils/app_constants.dart';
import 'package:get/get_connect.dart';

class UserRepo{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}