import 'package:first_project/controllers/cart_controller.dart';
import 'package:first_project/data/repository/popular_product_repo.dart';
import 'package:first_project/models/cart_model.dart';
import 'package:first_project/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProdsController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProdsController({required this.popularProductRepo});

  List<dynamic>_popularProductList=[];
  List<dynamic>get popularProductList=>_popularProductList;
  late CartController _cart;

  bool _isLoaded=false;
  bool get isLoaded =>_isLoaded;

  int _quantity=0;
  int get quantity=>_quantity;

  int _inCartItems=0;
  int get inCartItems=>_inCartItems+_quantity;

  Future<void> getPopularProductList() async {
    try {
      Response response = await popularProductRepo.getPopularProductList();

      if (response.statusCode == 200) {
        print("Got the products!");
        _popularProductList = [];
        _popularProductList.addAll(Product.fromJson(response.body).products as Iterable);
        _isLoaded=true;
        update();
      } else {
        print("Failed to get products. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error while fetching products: $e");
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity=checkQuantity(_quantity+1);
    }else{
      _quantity=checkQuantity(_quantity-1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Item count", "You can't reduce more !",
          backgroundColor: Color(0xFF89dad0),
          colorText: Colors.white);
      if(_inCartItems>0){
        return _quantity=-_inCartItems;
      }
      return 0;
    }else if((_inCartItems+quantity)>10){
      Get.snackbar("Item count", "You can't add more !",
          backgroundColor: Color(0xFF89dad0),
          colorText: Colors.white);
      return 10;
    }else{
      return quantity;
    }
  }

  //One Cart Controller common between all products
  void initProduct(ProductModel product,CartController cart){
    _quantity=quantity;
    _inCartItems=0;
    _cart=cart;
    var exist=false;
    exist=_cart.existInCart(product);
    print("Exist or not:"+exist.toString());
    if(exist){
      _inCartItems=_cart.getQuantity(product);
    }
    print("the quantity is:"+_inCartItems.toString());
  }

  void addItem(ProductModel product){
    _cart.addItem(product, _quantity);
    _quantity=0;
    _inCartItems=_cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("id:"+value.id.toString()+" quantity:"+value.quantity.toString());
    });
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel>get getItems{
    return _cart.getItems;
  }
}