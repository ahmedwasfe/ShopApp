import 'dart:developer';
import 'dart:ui';

import 'package:bmi_calculator/layout/shop_app/cubit/cubit.dart';
import 'package:bmi_calculator/models/shop/home/products_model.dart';
import 'package:bmi_calculator/modules/shop/product_details/cubit/cubit.dart';
import 'package:bmi_calculator/modules/shop/product_details/cubit/states.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/style/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantity_input/quantity_input.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen(this.productId, this.product);

  Products? product;
  int? productId;

  @override
  Widget build(BuildContext context) {
    log("build Id: $productId");
    log("build Id: ${product!.name}");
    return BlocProvider(
      create: (BuildContext context) => ProductDetailsCubit(),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ProductDetailsCubit cubit = ProductDetailsCubit.getCubit(context);
          ShopCubit shopCubit = ShopCubit.getCubit(context);
          // Products? products = cubit.productDetails!.product;
          // List<dynamic>? images = products!.images;
          return Scaffold(
            appBar: AppBar(title: Text("${product!.name}")),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    elevation: 10.0,
                    shadowColor: deepDefaultColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35.0),
                            bottomRight: Radius.circular(35.0))),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: 300.0,
                          autoPlay: true,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false),
                      items: product!.images!
                          .map((item) => Container(
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Image(
                                  image: NetworkImage('${item}'),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product!.name}",
                          style: TextStyle(
                              fontSize: 18.0,
                              height: 1.4,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text(
                                "${cubit.newPrice(product!.price)}${Const.USD}",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: deepDefaultColor)),
                            SizedBox(width: 10.0),
                            if (product!.discount != 0)
                              Text(
                                "${product!.oldPrice}${Const.USD}",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey[800],
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            Spacer(),
                            Row(
                              children: [
                                FloatingActionButton(
                                    mini: true,
                                    child: Icon(Icons.remove),
                                    onPressed: () => cubit.removeQuantity()),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text("${cubit.quantity}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    )),
                                SizedBox(
                                  width: 10.0,
                                ),
                                FloatingActionButton(
                                    mini: true,
                                    child: Icon(Icons.add),
                                    onPressed: () => cubit.addQuantity()),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text("${product!.description}",),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                  width: 200.0,
                                  height: 50.0,
                                  radius: 10.0,
                                  text: shopCubit.carts[productId]!
                                      ? "Added to cart"
                                      : "Add to cart",
                                  click: () => shopCubit.changeCarts(productId)),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              elevation: 18.0,
                              shadowColor: deepDefaultColor,
                              child: IconButton(
                                icon: CircleAvatar(
                                  backgroundColor:
                                      shopCubit.favorites[productId]!
                                          ? deepDefaultColor
                                          : Colors.grey,
                                  child: Icon(
                                    Icons.favorite_outline,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  shopCubit.changeFavorite(productId);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
