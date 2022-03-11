import 'package:bmi_calculator/layout/shop_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/shop_app/cubit/states.dart';
import 'package:bmi_calculator/models/shop/favorite/favorites_model.dart';
import 'package:bmi_calculator/models/shop/product/product.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/style/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit shopCubit = ShopCubit.getCubit(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){
        if(state is ShopFavoritesSuccessState){

        }
      },
      builder: (context, state) {
        var favorites = shopCubit.allFavorites!.data!.products;
        return ConditionalBuilder(
          condition: state is! FavoriteLoadingState,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildFavoriteItem(shopCubit, favorites![index]),
              separatorBuilder: (context, index) => buildSeperator(),
              itemCount: favorites!.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      }
    );
  }

  Widget buildFavoriteItem(ShopCubit shopCubit, Product favorite) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shadowColor: deepDefaultColor,
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
      ),
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
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Ink.image(
                    image: NetworkImage('${favorite.product!.image}'),
                    height: 120.0,
                    width: 120.0,
                    // colorFilter: Helper.greyScale(),
                    fit: BoxFit.cover,
                  ),
                  if (favorite.product!.discount != 0)
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
                    "${favorite.product!.name}",
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
                        '${favorite.product!.price} ${Const.USD}',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: deepDefaultColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 5.0),
                      if (favorite.product!.discount != 0)
                        Text(
                          '${favorite.product!.oldPrice} ${Const.USD}',
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
                          backgroundColor: shopCubit.favorites[favorite.product!.id]!
                              ? deepDefaultColor
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_outline,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          shopCubit.changeFavorite(favorite.product!.id);
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
}
