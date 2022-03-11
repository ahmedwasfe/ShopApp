
import 'package:bmi_calculator/models/shop/home/banners_model.dart';
import 'package:bmi_calculator/models/shop/home/products_model.dart';

class HomeModel {
  bool? status;
  // String? message;
  HomeData? data;

  HomeModel.fromJson(Map<String, dynamic> jsonData){
    status = jsonData['status'];
    // message = jsonData['message'];
    data = HomeData.fromJson(jsonData['data']);
  }
}

class HomeData{

  List<Banners>? banners;
  List<Products>? products;
  String? ads;

  HomeData({
    this.banners,
    this.products,
    this.ads,
  });

  HomeData.fromJson(Map<String, dynamic> jsonData){
    if(jsonData['banners'] != null){
      banners = [];
      jsonData['banners'].forEach((element) => banners!.add(Banners.fromJson(element)));
    }
    if(jsonData['products'] != null){
      products = [];
      jsonData['products'].forEach((element) => products!.add(Products.fromJson(element)));
    }
    ads = jsonData['ad'];
  }

}
