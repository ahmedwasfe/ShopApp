import 'package:bmi_calculator/models/shop/cart/cart_model.dart';

class ChangeCart{
  bool? status;
  String? message;
  CartItems? cartItems;

  ChangeCart.fromJson(Map<String, dynamic> jsonData){
    status = jsonData['status'];
    message = jsonData['message'];
    cartItems = jsonData['data'] != null ? CartItems.fromJson(jsonData['data']) : null;
  }
}