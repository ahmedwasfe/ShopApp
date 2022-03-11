import 'package:bmi_calculator/layout/news_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/news_app/cubit/states.dart';
import 'package:bmi_calculator/layout/todo_app/cubit/cubit.dart';
import 'package:bmi_calculator/modules/news/search/search_screen.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsHomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit newsCubit = NewsCubit.getCubit(context);
        AppCubit appCubit = AppCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(newsCubit.listTitle[newsCubit.currenNavIndex]),
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: () => navigateTo(context, SearchScreen())),
              IconButton(
                  icon: Icon(
                      appCubit.isDark
                          ? Icons.brightness_6_rounded
                          : Icons.brightness_2_rounded
                  ),
                  onPressed: () {
                    AppCubit.getCubit(context).changeThemeApp();
                  }),
            ],
          ),
          body: newsCubit.listScreens[newsCubit.currenNavIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: newsCubit.currenNavIndex,
            onTap: (index) {
              newsCubit.getCurrentNavIndex(index);
            },
            items: newsCubit.listBottomItems,
          ),
        );
      },
    );
  }
}
