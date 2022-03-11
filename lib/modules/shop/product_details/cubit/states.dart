import 'package:bmi_calculator/models/shop/product_details/product_details_model.dart';

abstract class ProductDetailsStates {}

class ProductInitState extends ProductDetailsStates {}

class ProductLoadingState extends ProductDetailsStates {}

class ProductDetailsSuccessState extends ProductDetailsStates {
  ProductDetails? productDetails;

  ProductDetailsSuccessState(this.productDetails);
}

class ProductDetailsFailedState extends ProductDetailsStates {
  String? error;

  ProductDetailsFailedState(this.error);
}

class AddQuantityState extends ProductDetailsStates{}

class RemoveQuantityState extends ProductDetailsStates{}
