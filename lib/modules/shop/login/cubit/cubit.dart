import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/models/shop/user/user_model.dart';
import 'package:bmi_calculator/modules/shop/login/cubit/states.dart';
import 'package:bmi_calculator/shared/network/end_points.dart';
import 'package:bmi_calculator/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitState());

  bool isVisiblePassword = true;
  IconData visiblePassIcon = Icons.visibility_outlined;

  User? login;

  static ShopLoginCubit getCubit(context) => BlocProvider.of(context);

  void visiblePassword(){
    isVisiblePassword = !isVisiblePassword;
    visiblePassIcon = isVisiblePassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ShopVisiblePasswordState());
  }

  void loginUser({
  required String email,
  required String password,
}){
    emit(ShopLoginLoadingState());

    DioHelper.postShopData(endPoint: LOGIN, data: {
      'email':'$email',
      'password':'$password',
    }, lang: 'en').then((value) {
      print("then Login: $value");
      login = User.fromJson(value.data);
      print(login!.status);
      print(login!.message);
      emit(ShopLoginSuccessState(login!));
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(ShopLoginFailedState(error.toString()));
    });
  }

}