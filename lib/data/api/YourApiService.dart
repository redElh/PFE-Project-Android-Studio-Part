import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
class YourApiService extends GetConnect implements GetxService{
   Future<Response> postData(String uri, Map<String, dynamic> body) async {
    try {
      final response = await post(uri, body);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}