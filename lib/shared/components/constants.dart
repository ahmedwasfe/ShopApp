
import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/modules/shop/login/shop_login_screen.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

// API
// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=d9752886d47246d182fd86a3e39bdbd6
// Search
// https://newsapi.org/v2/everything?q=Apple&apiKey=d9752886d47246d182fd86a3e39bdbd6

class Const {
  static final String KEY_DARK_MODE = 'dark_mode';
  static final String KEY_BOARDING = 'boarding';
  static final String KEY_USER_TOKEN = 'user_token';
  static final String KEY_USER_NAME = 'user_name';
  static final String USD = '\$';
}

class Helper {

  static String getCurrenToken(){
    return CacheHelper.getData(key: Const.KEY_USER_TOKEN);
  }

  /*
  * static final RegExp emailValidate = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  * */
  static RegExp emailValidate(){
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  }

  static void signOut(context){
    CacheHelper.removeData(key: Const.KEY_USER_TOKEN).then((value) {
      if (value) navigateAndFinish(context, ShopLoginScreen());
    });
  }

  static void printFullText(String text){
    // 800 is the size of each chunk
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((element) => print(element.group(0)));
  }

  static ColorFilter greyScale(){
    return ColorFilter.matrix(<double>[
      /// greyscale filter
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0, 0, 0, 1, 0
    ]);
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}