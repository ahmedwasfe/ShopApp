import 'package:bmi_calculator/layout/news_app/cubit/states.dart';
import 'package:bmi_calculator/modules/news/bussines/bussines_screen.dart';
import 'package:bmi_calculator/modules/news/science/science_screen.dart';
import 'package:bmi_calculator/modules/news/settings/settings_screen.dart';
import 'package:bmi_calculator/modules/news/sports/sport_screen.dart';
import 'package:bmi_calculator/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitState());

  int currenNavIndex = 0;
  List<dynamic> listSearch = [];
  List<dynamic> listBussines = [];
  List<dynamic> listSports = [];
  List<dynamic> listSciences = [];
  List<BottomNavigationBarItem> listBottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_sharp), label: "Bussines"),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_bar_rounded), label: "Sport"),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_rounded), label: "Science"),
  ];

  List<Widget> listScreens = [
    BussinesScreen(),
    SportScreen(),
    ScienceScreen(),
  ];
  List<String> listTitle = ["Bussines", "Sport", "Science"];

  static NewsCubit getCubit(context) => BlocProvider.of(context);

  void getCurrentNavIndex(int currenNavIndex) {
    this.currenNavIndex = currenNavIndex;
    if (currenNavIndex == 1)
      getSports();
    else if (currenNavIndex == 2) getSciences();
    emit(BottomNavState());
  }

  void getBussines() {
    emit(NewsBussinesLoadingState());
    DioHelper.getNewsData(pathUrl: "v2/top-headlines", query: {
      "country": "eg",
      "category": "business",
      "apiKey": "d9752886d47246d182fd86a3e39bdbd6",
    }).then((value) {
      listBussines = value.data['articles'];
      emit(NewsBussinesSuccessState());
      print(
          "then Size: ${listBussines.length}: Title: ${listBussines[0]['title']}");
      // print("then: ${value.news['articles'][8]['title']}");
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(NewsBussinesFailedState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsSportLoadingState());
    if (listSports.length == 0) {
      DioHelper.getNewsData(pathUrl: "v2/top-headlines", query: {
        "country": "eg",
        "category": "sports",
        "apiKey": "d9752886d47246d182fd86a3e39bdbd6",
      }).then((value) {
        listSports = value.data['articles'];
        emit(NewsSportSuccessState());
        print(
            "then Size: ${listSports.length}: Title: ${listSports[0]['title']}");
        // print("then: ${value.news['articles'][8]['title']}");
      }).catchError((error) {
        print("catchError: ${error.toString()}");
        emit(NewsSportFailedState(error.toString()));
      });
    } else
      emit(NewsSportSuccessState());
  }

  void getSciences() {
    emit(NewsScienceLoadingState());
    if (listSciences.length == 0) {
      DioHelper.getNewsData(pathUrl: "v2/top-headlines", query: {
        "country": "eg",
        "category": "science",
        "apiKey": "d9752886d47246d182fd86a3e39bdbd6",
      }).then((value) {
        listSciences = value.data['articles'];
        emit(NewsScienceSuccessState());
        print(
            "then Size: ${listSciences.length}: Title: ${listSciences[0]['title']}");
        // print("then: ${value.news['articles'][8]['title']}");
      }).catchError((error) {
        print("catchError: ${error.toString()}");
        emit(NewsScienceFailedState(error.toString()));
      });
    } else
      emit(NewsScienceSuccessState());
  }

  void search(String search){
    emit(NewsSearchLoadingState());
    listSearch.clear();
    if(listSearch.length == 0){
      DioHelper.getNewsData(
          pathUrl: 'v2/everything',
          query: {
            "q": '$search',
            "apiKey": "d9752886d47246d182fd86a3e39bdbd6",
          }).then((value) {
            listSearch = value.data['articles'];
            print(
                "then Search: Size: ${listSearch.length}: Title: ${listSearch[0]['title']}");
            emit(NewsSearchSuccessState());
      })
      .catchError((error) {
        print("catchError: ${error.toString()}");
        emit(NewsSearchFailedState(error.toString()));
      });
    }else
      emit(NewsSearchSuccessState());
  }
}
