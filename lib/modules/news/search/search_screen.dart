import 'package:bmi_calculator/layout/news_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/news_app/cubit/states.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {  },
      builder: (context, state) {
        NewsCubit newsCubit = NewsCubit.getCubit(context);
        var listSearch = newsCubit.listSearch;
        return Scaffold(
          appBar: AppBar(title: Text("Search")),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    lable: "Search",
                    prefix: Icons.search,
                    validate: (value) {
                      if(value!.isEmpty)
                        return "Please enter search word";
                      return null;
                    },
                    onChange: (value) {
                      newsCubit.search(value);
                      print("onChange: $value");
                    }),
              ),
              Expanded(
                  child: articleBuilder(listSearch, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}

/*
*
* 
* */
