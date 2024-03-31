import 'package:first_project/data/repository/recommended_product_repo.dart';
import 'package:first_project/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProdsController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProdsController({required this.recommendedProductRepo});

  List<dynamic>_recommendedProductList=[];
  List<dynamic>get recommendedProductList=>_recommendedProductList;

  bool _isLoaded=false;
  bool get isLoaded =>_isLoaded;

  Future<void> getRecommendedProductList() async {
    try {
      Response response = await recommendedProductRepo.getRecommendedProductList();

      if (response.statusCode == 200) {
        print("Got the products!");
        _recommendedProductList = [];
        _recommendedProductList.addAll(Product.fromJson(response.body).products as Iterable);
        _isLoaded=true;
        update();
      } else {
        print("Failed to get products. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error while fetching products: $e");
    }
  }
}