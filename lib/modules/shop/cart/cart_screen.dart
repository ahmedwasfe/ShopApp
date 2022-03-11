import 'dart:math';

import 'package:bmi_calculator/layout/shop_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/shop_app/cubit/states.dart';
import 'package:bmi_calculator/models/shop/cart/cart_model.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/style/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  List<CartItems>? carts = [];
  CartData? cartData = CartData.empty();

  @override
  Widget build(BuildContext context) {
    ShopCubit shopCubit = ShopCubit.getCubit(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (shopCubit.cart != null)
          carts = shopCubit.cart!.cartData!.cartItems;
        if (cartData != null) {
          cartData = shopCubit.cart!.cartData!;
        }
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: ConditionalBuilder(
                      condition: state is! CartLoadingState,
                      builder: (context) => ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) =>
                              buildCartItem(shopCubit, carts![index]),
                          separatorBuilder: (context, index) =>
                              buildSeperator(),
                          itemCount: carts!.length),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator())),
                ),
                Card(
                  margin: EdgeInsets.all(10.0),
                  clipBehavior: Clip.antiAlias,
                  elevation: 20.0,
                  shadowColor: deepDefaultColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Sub Total: ${checkDouble(cartData!.subTotal)} ${Const.USD}"),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text('Total: ${checkDouble(shopCubit.cart!.cartData!.total!.round())}'),
                          ],
                        ),
                        Spacer(),
                        CustomButton(
                            text: "Checkout",
                            width: 120.0,
                            height: 40.0,
                            radius: 10.0,
                            click: () {})
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCartItem(shopCubit, CartItems cart) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shadowColor: deepDefaultColor,
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        height: 120.0,
        padding: EdgeInsets.all(10.0),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Colors.blueAccent, Colors.blue],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   )
        // ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Ink.image(
                    image: NetworkImage('${cart.product!.image}'),
                    height: 120.0,
                    width: 120.0,
                    // colorFilter: Helper.greyScale(),
                    fit: BoxFit.cover,
                  ),
                  if (cart.product!.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'Discount',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${cart.product!.name}",
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${cart.product!.price} ${Const.USD}',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: deepDefaultColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 5.0),
                      if (cart.product!.discount != 0)
                        Text(
                          '${cart.product!.oldPrice} ${Const.USD}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 8.0,
                            color: Colors.grey[900],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      Spacer(),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              shopCubit.favorites[cart.product!.id]!
                                  ? deepDefaultColor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_outline,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          print("ProductId ${cart.product!.id}");
                          shopCubit.changeFavorite(cart.product!.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double checkDouble(dynamic value) {
    if (value is int)
      return double.parse(value.toString());
    else if (value is double)
      return double.parse(value.toString());
    else
      return value;
  }
}
