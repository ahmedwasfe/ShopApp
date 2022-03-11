import 'package:bmi_calculator/layout/shop_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/shop_app/cubit/states.dart';
import 'package:bmi_calculator/models/shop/categories/categories_model.dart';
import 'package:bmi_calculator/modules/shop/products_category/products_category.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.getCubit(context);
        List<Category>? categories = shopCubit.categories.data!.categories;
        return ConditionalBuilder(
          condition: shopCubit.categories != null,
          builder: (context) => GridView.count(
            children: List.generate(categories!.length, (index) {
              Category category = categories[index];
              return buildCategoryItem(context, category);
            }),
            crossAxisCount: 2,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildCategoryItem(BuildContext context, Category category) => InkWell(
        child: Card(
          margin: EdgeInsets.all(18.0),
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Ink.image(
                image: NetworkImage('${category.image}'),
                height: 220.0,
                fit: BoxFit.cover,),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(
                  "${category.name}",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Spacer(),
              // Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
    onTap: () => navigateTo(context, ProductsCategoryScreen(category)),
      );
}
