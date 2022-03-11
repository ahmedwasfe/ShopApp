import 'dart:developer';
import 'dart:math';

import 'package:bmi_calculator/layout/shop_app/cubit/states.dart';
import 'package:bmi_calculator/models/shop/cart/cart_model.dart';
import 'package:bmi_calculator/models/shop/cart/change_cart_model.dart';
import 'package:bmi_calculator/models/shop/categories/categories_model.dart';
import 'package:bmi_calculator/models/shop/favorite/change_favorite_model.dart';
import 'package:bmi_calculator/models/shop/favorite/favorites_model.dart';
import 'package:bmi_calculator/models/shop/home/home_model.dart';
import 'package:bmi_calculator/models/shop/products_category/products_category_model.dart';
import 'package:bmi_calculator/models/shop/user/user_model.dart';
import 'package:bmi_calculator/modules/shop/categories/categories_screen.dart';
import 'package:bmi_calculator/modules/shop/favorites/favorites_screen.dart';
import 'package:bmi_calculator/modules/shop/home/home_screen.dart';
import 'package:bmi_calculator/modules/shop/profile/profile_screen.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/network/end_points.dart';
import 'package:bmi_calculator/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());

  HomeModel? homeModel;
  Categories categories = Categories.empty();
  ProductsCategory? productsCategory;

  ChangeFavorite? changeFavorites;
  Favorites? allFavorites;
  int? favoritesCount;
  Map<int, bool> favorites = {};

  Cart? cart;
  ChangeCart? changeCart;
  int? cartCount;
  Map<int, bool> carts = {};

  User? user;

  int currentNavIndex = 0;
  List<Widget> listNavScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];
  List<String> listTites = ["Products", "Categories", "Favorite", "Profile"];

  static ShopCubit getCubit(context) => BlocProvider.of(context);

  void getCurrenNavIndex(int currentNavIndex) {
    this.currentNavIndex = currentNavIndex;
    emit(ShopChangeBottomNavState());
  }

  int? getFavoritesCouts() {
    return favoritesCount;
  }

  int? getCartsCouts() {
    return cartCount;
  }

  // APIs

  String _getToken() {
    return Helper.getCurrenToken();
  }

  void getHomeData() {
    emit(ShopLoadingState());

    print("getHomeData: ${_getToken()}");
    DioHelper.getShopData(pathUrl: HOME, token: _getToken()).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print("getHomeData: ${homeModel!.status}");
      // print("getHomeData: ${homeModel!.data!.products!.length}");
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorite!,
        });
        carts.addAll({element.id!: element.inCart!});
      });
      print("Favorites: ${favorites.toString()}");
      print("Carts: ${carts.toString()}");
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(ShopHomeFailedState(error.toString()));
    });
  }

  void getCategories() {
    emit(ShopLoadingState());
    DioHelper.getShopData(pathUrl: CATEGORIES).then((value) {
      categories = Categories.fromJson(value.data);
      print("getCategories: ${categories.status}");
      print("getCategories: ${categories.data!.categories!.length}");
      print("getCategories: ${categories.data!.categories![0].name}");
      emit(ShopCategorySuccessState());
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(ShopCategoryFailedState(error.toString()));
    });
  }

  void changeFavorite(int? productId) {
    favorites[productId!] = !favorites[productId]!;
    emit(ShopChangeFavoriteState());

    DioHelper.postShopData(
            endPoint: FAVORITES,
            data: {"product_id": productId},
            token: _getToken())
        .then((value) {
      changeFavorites = ChangeFavorite.fromJson(value.data);
      if (!changeFavorites!.status!)
        favorites[productId] = !favorites[productId]!;
      else
        getFavorites();
      print("changeFavorite: ${changeFavorites!.message}");
      emit(ShopChangeFavoriteSuccessState(changeFavorites));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print("catchError: ${error.toString()}");
      emit(ShopChangeFavoriteFailedState(error.toString()));
    });
  }

  void getFavorites() {
    emit(FavoriteLoadingState());
    DioHelper.getShopData(pathUrl: FAVORITES, token: _getToken()).then((value) {
      allFavorites = Favorites.fromJson(value.data);
      // print("getFavorites: ${value.data}");
      favoritesCount = allFavorites!.data!.products!.length;
      emit(ShopFavoritesSuccessState(allFavorites));
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(ShopFavoritesFailedState(error.toString()));
    });
  }

  void getUserProfile() {
    emit(ShopLoadingState());
    DioHelper.getShopData(pathUrl: PROFILE, token: _getToken()).then((value) {
      user = User.fromJson(value.data);
      print("${user!.data!.name}");
      emit(ShopUserProfileSuccessState(user));
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(ShopUserProfileFailedState(error.toString()));
    });
  }

  void updateUserProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingState());
    DioHelper.putShopData(
      endPoint: UPDATE_PROFILE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: _getToken(),
    ).then((value) {
      user = User.fromJson(value.data);
      print("NAME: ${user!.data!.name}");
      emit(ShopUpdateProfileSuccessState(user));
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(ShopUpdateProfileFailedState(error.toString()));
    });
  }

  void getCarts() {
    emit(CartLoadingState());
    DioHelper.getShopData(pathUrl: CART, token: _getToken()).then((value) {
      cart = Cart.fromJson(value.data);
      cartCount = cart!.cartData!.cartItems!.length;
      emit(ShopCartSuccessState(cart));
    }).catchError((error) {
      print("getCarts catchError: ${error.toString()}");
      emit(ShopCartFailedState(error.toString()));
    });
  }

  void changeCarts(int? productId) {
    carts[productId!] = !carts[productId]!;
    emit(ShopChangeCartState());

    DioHelper.postShopData(
            endPoint: CART,
            data: {
              'product_id': productId,
            },
            token: _getToken())
        .then((value) {
      changeCart = ChangeCart.fromJson(value.data);
      if (!changeCart!.status!)
        carts[productId] = !carts[productId]!;
      else
        getCarts();
      print("change Cart: ${changeCart!.message}");
      emit(ShopChangeCartSuccessState(changeCart));
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(ShopChangeCartFailedState(error.toString()));
    });
  }
  
  void getProductsByCategory(int categoryId){
    emit(ShopLoadingState());
    DioHelper.getShopData(pathUrl: PRODUCTS,
    query: {'category_id': categoryId})
    .then((value) {
      productsCategory = ProductsCategory.fromJson(value.data);
      emit(ProductsCategorySuccessState(productsCategory));
    })
    .catchError((error) {
      print("catchError: ${error.toString()}");
      emit(ProductsCategoryFailedState(error.toString()));
    });
  }
}
