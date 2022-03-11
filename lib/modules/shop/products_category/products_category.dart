import 'package:bmi_calculator/layout/shop_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/shop_app/cubit/states.dart';
import 'package:bmi_calculator/models/shop/categories/categories_model.dart';
import 'package:bmi_calculator/models/shop/home/products_model.dart';
import 'package:bmi_calculator/modules/shop/product_details/product_details.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/style/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCategoryScreen extends StatelessWidget {
  ProductsCategoryScreen(this.category);

  Category? category;
  List<Products>? products = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.getCubit(context);
        shopCubit.getProductsByCategory(category!.id!);
        if (shopCubit.productsCategory != null)
          products = shopCubit.productsCategory!.productsCategoryData!.products!;
        return Scaffold(
          appBar: AppBar(title: Text("${category!.name}")),
          body: ConditionalBuilder(
            condition: products!.length != 0 && products != null,
            builder: (context) => Container(
              child: GridView.count(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 1 / 1.62,
                children: List.generate(products!.length, (index) {
                  Products product = products![index];
                  return buildProductItem(context, product);
                }),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
