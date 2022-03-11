import 'package:bmi_calculator/layout/shop_app/cubit/cubit.dart';
import 'package:bmi_calculator/models/shop/home/products_model.dart';
import 'package:bmi_calculator/modules/shop/search/cubit/cubit.dart';
import 'package:bmi_calculator/modules/shop/search/cubit/states.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit searchCubit = SearchCubit.getCubit(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomFormField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          lable: "What are you looking for?",
                          prefix: Icons.search_outlined,
                          radius: 10.0,
                          validate: (value){
                            if(value!.isEmpty)
                              return "Please enter any word";
                            return null;
                          },
                      onSubmit: (value) => searchCubit.search(value)),
                      SizedBox(height: 10.0,),
                      if(state is SearchLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(height: 20.0,),
                      if(state is SearchSuccessState)
                        Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildSearchItem(context, searchCubit.searchModel!.data!.products![index]),
                            separatorBuilder: (context, index) => buildSeperator(),
                            itemCount: searchCubit.searchModel!.data!.products!.length),
                           //                      searchModel!.data!.products!.length}
                      )
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(context, Products product) {
    ShopCubit shopCubit = ShopCubit.getCubit(context);
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
                    image: NetworkImage('${product.image}'),
                    height: 120.0,
                    width: 120.0,
                    // colorFilter: Helper.greyScale(),
                    fit: BoxFit.cover,
                  ),
                  if (product.discount != 0)
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
                    "${product.name}",
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
                        '${product.price} ${Const.USD}',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: deepDefaultColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 5.0),
                      if (product.discount != 0)
                        Text(
                          '${product.oldPrice} ${Const.USD}',
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
                          backgroundColor: shopCubit.favorites[product.id]!
                              ? deepDefaultColor
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_outline,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          print("ProductId ${product.id}");
                          shopCubit.changeFavorite(product.id);
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
