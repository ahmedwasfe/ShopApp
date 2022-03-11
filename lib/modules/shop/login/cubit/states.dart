import 'package:bmi_calculator/models/shop/user/user_model.dart';

abstract class ShopLoginStates {
}

class ShopLoginInitState extends ShopLoginStates {}

class ShopVisiblePasswordState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final User? login;
  ShopLoginSuccessState(this.login);
}

class ShopLoginFailedState extends ShopLoginStates {
  final String error;

  ShopLoginFailedState(this.error);
}
