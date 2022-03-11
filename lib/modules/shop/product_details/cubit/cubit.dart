import 'package:bmi_calculator/models/shop/home/products_model.dart';
import 'package:bmi_calculator/models/shop/product_details/product_details_model.dart';
import 'package:bmi_calculator/modules/shop/product_details/cubit/states.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/network/end_points.dart';
import 'package:bmi_calculator/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsCubit() : super(ProductInitState());

  int quantity = 1;
  dynamic? _newPrice;
  ProductDetails? productDetails;
  Products? product;
  List<String>? images;

  static ProductDetailsCubit getCubit(BuildContext context) =>
      BlocProvider.of(context);

  void getProductDetails(int? productId) {
    String token = Helper.getCurrenToken();
    emit(ProductLoadingState());
    DioHelper.getShopData(pathUrl: '${PRODUCT_DETAILS}$productId', token: token)
        .then((value) {
      productDetails = ProductDetails.fromJson(value.data);
      print("PATH ${PRODUCT_DETAILS}$productId");
      // print("getProductDetails: ${productDetails!.status}");
      product = productDetails!.product;
      images = productDetails!.product!.images!.cast<String>();
      print("getProductDetails: ${productDetails!.product!.images.toString()}");
      print("getProductDetails: ${productDetails!.product!.name}");
      emit(ProductDetailsSuccessState(productDetails));
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(ProductDetailsFailedState(error.toString()));
    });
  }

  int addQuantity() {
    emit(AddQuantityState());
    if(quantity == 20)
      return quantity = 20;
    else
      return quantity++;
  }

  int removeQuantity() {
    emit(RemoveQuantityState());
    if(quantity == 1)
      return quantity = 1;
    else
      return quantity--;
  }

  dynamic newPrice(dynamic price){
    _newPrice = price * quantity;
    return _newPrice;
  }
}