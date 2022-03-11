import 'package:bmi_calculator/models/shop/home/products_model.dart';

class ProductsCategory {
  bool? status;
  String? message;
  ProductsCategoryData? productsCategoryData;

  ProductsCategory.fromJson(Map<String, dynamic> jsonData){
    status = jsonData['status'];
    message = jsonData['message'];
    productsCategoryData = jsonData['data'] != null ? ProductsCategoryData.fromJson(jsonData['data']) : null;
  }
}

class ProductsCategoryData{

  int? currentPage;
  List<Products>? products;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  ProductsCategoryData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      products = [];
      json['data'].forEach((element) => products!.add(Products.fromJson(element)));
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}