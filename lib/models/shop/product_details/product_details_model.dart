import 'package:bmi_calculator/models/shop/home/products_model.dart';

class ProductDetails {
  bool? status;
  String? message;
  Products? product;

  ProductDetails.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
    product = jsonData['data'] != null ? Products.fromJson(jsonData['data']) : null;
  }
}
