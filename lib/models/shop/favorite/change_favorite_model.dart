import 'package:bmi_calculator/models/shop/home/products_model.dart';

class ChangeFavorite{

  bool? status;
  String? message;
  // ChangeFavoriteData? data;

  ChangeFavorite.fromJson(Map<String, dynamic> jsonData){
    status = jsonData['status'];
    message = jsonData['message'];
    // data = ChangeFavoriteData.fromJson(jsonData['data']);
  }
}

class ChangeFavoriteData {
  int? id;
  Products? product;

  ChangeFavoriteData.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    product = jsonData['product'];
  }
}