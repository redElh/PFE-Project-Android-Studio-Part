import 'package:first_project/models/user_model.dart';
import 'package:first_project/models/cart_model.dart';

class CheckoutDataModel {
  final UserModel user;
  final List<CartModel> cartItems;

  CheckoutDataModel({required this.user, required this.cartItems});

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'cartItems': cartItems.map((item) => item.toJson()).toList(),
    };
  }
}