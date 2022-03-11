import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/models/shop/user/user_model.dart';
import 'package:bmi_calculator/modules/shop/register/cubit/states.dart';
import 'package:bmi_calculator/shared/network/end_points.dart';
import 'package:bmi_calculator/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitState());

  bool isVisiblePassword = true;
  IconData visiblePassIcon = Icons.visibility_outlined;

  User? register;

  static ShopRegisterCubit getCubit(context) => BlocProvider.of(context);

  void visiblePassword() {
    isVisiblePassword = !isVisiblePassword;
    visiblePassIcon = isVisiblePassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ShopVisiblePasswordState());
  }

  void registerUser({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postShopData(
      endPoint: REGISTER,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password
      },
      lang: 'en',
    ).then((value) {
      print("then Register: $value");
      // register = User.fromJson(value.data);
      // print(login!.status);
      // print("Register: ${register!.message}");
      // print("Register: ${register!.data!.name}");
      emit(ShopRegisterSuccessState(register!));
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(ShopRegisterFailedState(error.toString()));
    });
  }

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }){
    emit(ShopRegisterLoadingState());
    Map<String, dynamic> data = {
      'name': '$name',
      'phone': phone,
      'email': email,
      'password': password,
    };
    DioHelper.signUpUser(data)
        .then((value) {
          print("then Register: ${value}");
          emit(ShopRegisterSuccessState(value.data));
    })
        .catchError((error) {
      print("catchError: ${error.toString()}");
      emit(ShopRegisterFailedState(error.toString()));
    });
  }
}
