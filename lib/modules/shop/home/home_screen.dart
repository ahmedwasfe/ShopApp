import 'dart:developer';

import 'package:bmi_calculator/layout/shop_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/shop_app/cubit/states.dart';
import 'package:bmi_calculator/models/shop/categories/categories_model.dart';
import 'package:bmi_calculator/models/shop/home/banners_model.dart';
import 'package:bmi_calculator/models/shop/home/home_model.dart';
import 'package:bmi_calculator/models/shop/home/products_model.dart';
import 'package:bmi_calculator/modules/shop/product_details/product_details.dart';
import 'package:bmi_calculator/modules/shop/products_category/products_category.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/style/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopChangeFavoriteSuccessState){
          print("listener: ${state.favorite!.status!}");
          if(state.favorite!.status!)
            showToast(message: state.favorite!.message!, state: ToastStates.SUCCESS);
          else
            showToast(message: state.favorite!.message!, state: ToastStates.FAILED);
        }
      },
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.getCubit(context);
        return ConditionalBuilder(
          condition:
              shopCubit.homeModel != null && shopCubit.categories != null,
          builder: (context) =>
              buildHome(context, shopCubit.homeModel, shopCubit.categories),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildHome(context, HomeModel? homeModel, Categories categories) {
    List<Banners>? listBanners = homeModel!.data!.banners;
    List<Products>? listProducts = homeModel.data!.products;
    List<Category>? listCategories = categories.data!.categories;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
            ),
            items: listBanners!
                .map((item) => Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Image(
                        image: NetworkImage('${item.image}'),
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ))
                .toList(),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      Category category = listCategories![index];
                      return buildCategoryItem(context, category);
                    },
                    itemCount: listCategories!.length,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              childAspectRatio: 1 / 1.62,
              children: List.generate(listProducts!.length, (index) {
                Products product = listProducts[index];
                return buildProductItem(context, product);
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategoryItem(BuildContext context, Category category) => InkWell(
    child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image(
                image: NetworkImage('${category.image}'),
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    '${category.name}',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
    onTap: () => navigateTo(context, ProductsCategoryScreen(category)),
  );
}
