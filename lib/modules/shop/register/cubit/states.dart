import 'package:bmi_calculator/models/shop/user/user_model.dart';

abstract class ShopRegisterStates {
}

class ShopRegisterInitState extends ShopRegisterStates {}

class ShopVisiblePasswordState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final User? register;
  ShopRegisterSuccessState(this.register);
}

class ShopRegisterFailedState extends ShopRegisterStates {
  final String error;
  ShopRegisterFailedState(this.error);
}
