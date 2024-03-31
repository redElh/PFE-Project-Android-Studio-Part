import 'package:first_project/data/api/api_client.dart';
import 'package:first_project/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    try {
      Response response = await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
      return response;
    } catch (e) {
      // Handle errors here, you can return an error response or throw an exception
      return Response(statusCode: 500, statusText: 'Error fetching popular products: $e');
    }
  }
}