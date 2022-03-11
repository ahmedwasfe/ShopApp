import 'package:bmi_calculator/layout/shop_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/todo_app/cubit/cubit.dart';
import 'package:bmi_calculator/models/shop/boarding_model.dart';
import 'package:bmi_calculator/models/shop/home/products_model.dart';
import 'package:bmi_calculator/models/shop/product/product.dart';
import 'package:bmi_calculator/modules/news/news_details/news_details.dart';
import 'package:bmi_calculator/modules/shop/product_details/product_details.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/style/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget CustomButton({
  required String text,
  required Function() click,
  double width = double.infinity,
  double height = 48.0,
  Color background = Colors.blueAccent,
  bool isUpperCase = true,
  Color textColor = Colors.white,
  double radius = 0.0,
  double marginLeft = 0.0,
}) =>
    Container(
      margin: EdgeInsets.only(left: marginLeft),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: click,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: textColor),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget CustomFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String lable,
  required IconData prefix,
  required FormFieldValidator<String> validate,
  bool isEnable = true,
  IconData? suffix,
  GestureTapCallback? onTab,
  Function()? suffixClick,
  ValueChanged? onChange,
  ValueChanged? onSubmit,
  bool isPassword = false,
  double radius = 8.0,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: isEnable,
      obscureText: isPassword,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTap: onTab,
      validator: validate,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixClick,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );

Widget buildTasksItem(context, Map listTask) {
  AppCubit appCubit = AppCubit.getCubit(context);
  print(listTask['status']);
  return Dismissible(
    key: Key(listTask['id'].toString()),
    onDismissed: (direction) {
      AppCubit.getCubit(context).deleteTask(id: listTask['id']);
    },
    child: GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Center(
                child: Text(
                  "${listTask['time']}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${listTask['title']}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 8.0),
                  Text("${listTask['date']}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      )),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
              icon: listTask['status'] == "Archived"
                  ? Icon(null)
                  : Icon(Icons.check_circle_outline_rounded,
                      color: Colors.green),
              onPressed: () {
                if (listTask['status'] == "New") {
                  appCubit.updateTask(status: "Done", id: listTask['id']);
                  print("DONE ${listTask['id']}: ${listTask['title']}");
                }
              },
            ),
            IconButton(
              icon: listTask['status'] == "Archived"
                  ? Icon(Icons.unarchive_outlined, color: Colors.green)
                  : Icon(Icons.archive_outlined, color: Colors.red),
              onPressed: () {
                if (listTask['status'] == "Archived")
                  appCubit.updateTask(status: "New", id: listTask['id']);
                else
                  appCubit.updateTask(status: "Archived", id: listTask['id']);
                print("ARCHIVE ${listTask['id']}: ${listTask['title']}");
              },
            ),
          ],
        ),
      ),
      onTap: () {
        Fluttertoast.showToast(
            msg: "${listTask['title']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white);
      },
    ),
  );
}

Widget ConditionEmptyBuilder({required List<Map> listTask}) =>
    ConditionalBuilder(
        condition: listTask.length > 0,
        builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  buildTasksItem(context, listTask[index]),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 25.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              itemCount: listTask.length,
            ),
        fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    size: 100.0,
                    color: Colors.grey,
                  ),
                  Text("No Tasks yet, PLease add some tasks",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey))
                ],
              ),
            ));

Widget buildArticleItem(context, listNews) => InkWell(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage('${listNews['urlToImage']}'),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${listNews['title']}",
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${listNews['publishedAt']}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        navigateTo(context, NewsDetails(listNews['url']));
      },
    );

Widget buildSeperator() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 25.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(listNews, {isSearch = false}) => ConditionalBuilder(
      condition: listNews.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(context, listNews[index]),
          separatorBuilder: (context, index) => buildSeperator(),
          itemCount: listNews.length),
      fallback: (context) => isSearch
          ? Container()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );

void navigateTo(context, screen) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

void navigateAndFinish(context, screen) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
    (Route<dynamic> route) => false);

Widget buildBoarding(Boarding board) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
          image: AssetImage('${board.image}'),
        )),
        Text('${board.title}',
            style: TextStyle(
              fontSize: 24.0,
            )),
        SizedBox(
          height: 15.0,
        ),
        Text('${board.body}',
            style: TextStyle(
              fontSize: 14.0,
            )),
        SizedBox(
          height: 20.0,
        ),
      ],
    );

Widget buildProductItem(context, Products product) {
  ShopCubit shopCubit = ShopCubit.getCubit(context);
  return InkWell(
    child: Card(
      margin: EdgeInsets.all(8.0),
      elevation: 10.0,
      shadowColor: deepDefaultColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage('${product.image}'),
                width: double.infinity,
                height: 200.0,
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.name}',
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${product.price.round()} ${Const.USD}',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: deepDefaultColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5.0),
                        if (product.discount != 0)
                          Text(
                            '${product.oldPrice.round()} ${Const.USD}',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 8.0,
                              color: Colors.grey[900],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        IconButton(
                          icon: CircleAvatar(
                            radius: 14.0,
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
                            shopCubit.changeFavorite(product.id);
                            // print("onPressed: ${shopCubit.favorite!.message}");
                          },
                        ),
                        IconButton(
                          icon: CircleAvatar(
                            radius: 14.0,
                            backgroundColor: shopCubit.carts[product.id]!
                                ? deepDefaultColor
                                : Colors.grey,
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            shopCubit.changeCarts(product.id);
                            // print("onPressed: ${shopCubit.favorite!.message}");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    onTap: () => navigateTo(context, ProductDetailsScreen(product.id, product)),
  );
}

void showToast({
  required String message,
  required ToastStates state,
}) => Fluttertoast
    .showToast(msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: chooseToastColor(state),
    timeInSecForIosWeb: 5,
    textColor: Colors.white);

enum ToastStates {SUCCESS, FAILED, WARNING, OTHERS}

Color chooseToastColor(ToastStates toastStates){
Color? color;
  switch(toastStates){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.FAILED:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.OTHERS:
      color = Colors.black;
      break;
    default:
      color = Colors.black;
  }
  return color;
}
