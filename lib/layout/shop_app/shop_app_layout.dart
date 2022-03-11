import 'package:badges/badges.dart';
import 'package:bmi_calculator/layout/shop_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/shop_app/cubit/states.dart';
import 'package:bmi_calculator/models/shop/favorite/favorites_model.dart';
import 'package:bmi_calculator/modules/shop/cart/cart_screen.dart';
import 'package:bmi_calculator/modules/shop/search/search_screen.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopHomeLayout extends StatelessWidget {
  const ShopHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "HomeLayout TOKEN: ${CacheHelper.getData(key: Const.KEY_USER_TOKEN)}");
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("${CacheHelper.getData(key: Const.KEY_USER_NAME)}"),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () => navigateTo(context, SearchScreen()),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, right: 20.0),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Badge(
                      badgeContent: Text(
                        "${shopCubit.getCartsCouts()}",
                        style: TextStyle(color: Colors.white),
                      ),
                      animationType: BadgeAnimationType.scale,
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart_outlined),
                        onPressed: () => navigateTo(context, CartScreen()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: shopCubit.listNavScreens[shopCubit.currentNavIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: shopCubit.currentNavIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "Categories"),
              BottomNavigationBarItem(icon: buildFavoriteIcon(shopCubit), label: "favorite"),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
            ],
            onTap: (index) => shopCubit.getCurrenNavIndex(index),
          ),
        );
      },
    );
  }

  Widget buildFavoriteIcon(ShopCubit shopCubit) => Container(
    // margin: EdgeInsets.only(top: 5.0, right: 10.0),
    child: Stack(
      children: [
        Badge(
          badgeContent: Text("${shopCubit.getFavoritesCouts()}",
            style: TextStyle(color: Colors.white),) ,
          animationType: BadgeAnimationType.scale,
          child: Icon(Icons.favorite_outline),
        ),
      ],
    ),
  );
}
