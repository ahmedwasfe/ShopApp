import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/layout/news_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/news_app/cubit/states.dart';
import 'package:bmi_calculator/layout/shop_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/shop_app/shop_app_layout.dart';
import 'package:bmi_calculator/layout/todo_app/todo_app_layout.dart';
import 'package:bmi_calculator/layout/news_app/news_app_layout.dart';
import 'package:bmi_calculator/modules/home/login/login.dart';
import 'package:bmi_calculator/modules/shop/boarding/boarding_screen.dart';
import 'package:bmi_calculator/modules/shop/login/shop_login_screen.dart';
import 'package:bmi_calculator/modules/social/login/social_login_screen.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/layout/todo_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/todo_app/cubit/states.dart';
import 'package:bmi_calculator/shared/network/local/cache_helper.dart';
import 'package:bmi_calculator/shared/network/remote/dio_helper.dart';
import 'package:bmi_calculator/shared/style/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'modules/bmi/bmi_screen/bmi_screen.dart';

void main() async {
  // بيتأكد ان كل حاجة ف الدالة خلصت وبعدين بيشغل التطبيق
  // يعني بيشغل كل الدوال الي قبل runApp وبعدين بيشغل ال runApp
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
    () {
      AppCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.initShopApp();
  // DioHelper.initTodoApp();
  await CacheHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool? isDark = CacheHelper.getDarkMode(key: Const.KEY_DARK_MODE);
  bool? boarding = CacheHelper.getData(key: Const.KEY_BOARDING);

  // String? token = Helper.getCurrenToken();

  Widget startApp() {
    // print("Current Token: ${Helper.getCurrenToken()}");
    if (boarding != null) {
      if (CacheHelper.getData(key: Const.KEY_USER_TOKEN) != null)
        return ShopHomeLayout();
      else
        return ShopLoginScreen();
    } else
      return BoardingScreen();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("build boarding: $boarding");

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBussines()
            ..getSports()
            ..getSciences(),
        ),
        BlocProvider(
          create: (_) => AppCubit()..changeThemeApp(darkMode: isDark),
        ),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getCarts()
              ..getUserProfile()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.getCubit(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme(),
            //  darkTheme: darkTheme(),
            home: startApp(),
          );
        },
      ),
    );
  }
}
