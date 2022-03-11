import 'package:bmi_calculator/models/shop/cart/cart_model.dart';
import 'package:bmi_calculator/models/shop/cart/change_cart_model.dart';
import 'package:bmi_calculator/models/shop/favorite/change_favorite_model.dart';
import 'package:bmi_calculator/models/shop/favorite/favorites_model.dart';
import 'package:bmi_calculator/models/shop/home/home_model.dart';
import 'package:bmi_calculator/models/shop/product_details/product_details_model.dart';
import 'package:bmi_calculator/models/shop/products_category/products_category_model.dart';
import 'package:bmi_calculator/models/shop/user/user_model.dart';

abstract class ShopStates {}

class ShopInitState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingState extends ShopStates {}


class ShopHomeSuccessState extends ShopStates {}

class ShopHomeFailedState extends ShopStates {
  final String error;
  ShopHomeFailedState(this.error);
}

class ShopCategorySuccessState extends ShopStates {}

class ShopCategoryFailedState extends ShopStates {
  final String error;
  ShopCategoryFailedState(this.error);
}

class ShopChangeFavoriteState extends ShopStates {}

class ShopChangeFavoriteSuccessState extends ShopStates {
  ChangeFavorite? favorite;
  ShopChangeFavoriteSuccessState(this.favorite);
}

class ShopChangeFavoriteFailedState extends ShopStates {
  final String error;
  ShopChangeFavoriteFailedState(this.error);
}

class FavoriteLoadingState extends ShopStates {}

class ShopFavoritesSuccessState extends ShopStates{
  Favorites? favorites;
  ShopFavoritesSuccessState(this.favorites);
}

class ShopFavoritesFailedState extends ShopStates{
  String? error;
  ShopFavoritesFailedState(this.error);
}

class CartLoadingState extends ShopStates {}

class ShopCartSuccessState extends ShopStates{
  Cart? cart;
  ShopCartSuccessState(this.cart);
}

class ShopCartFailedState extends ShopStates{
  String? error;
  ShopCartFailedState(this.error);
}

class ShopChangeCartState extends ShopStates {}

class ShopChangeCartSuccessState extends ShopStates {
  ChangeCart? cart;
  ShopChangeCartSuccessState(this.cart);
}

class ShopChangeCartFailedState extends ShopStates {
  final String error;
  ShopChangeCartFailedState(this.error);
}

class ShopUserProfileSuccessState extends ShopStates{
  User? user;
  ShopUserProfileSuccessState(this.user);
}

class ShopUserProfileFailedState extends ShopStates{
  String? error;
  ShopUserProfileFailedState(this.error);
}

class ShopUpdateProfileSuccessState extends ShopStates{
  User? user;
  ShopUpdateProfileSuccessState(this.user);
}

class ShopUpdateProfileFailedState extends ShopStates{
  String? error;
  ShopUpdateProfileFailedState(this.error);
}

class ProductsCategorySuccessState extends ShopStates{
  ProductsCategory? productsCategory;
  ProductsCategorySuccessState(this.productsCategory);
}

class ProductsCategoryFailedState extends ShopStates{
  String? error;
  ProductsCategoryFailedState(this.error);
}

