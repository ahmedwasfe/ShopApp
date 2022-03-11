import 'package:bmi_calculator/models/shop/search/search_model.dart';
import 'package:bmi_calculator/modules/shop/search/cubit/states.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/network/end_points.dart';
import 'package:bmi_calculator/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitState());

  static SearchCubit getCubit(context) => BlocProvider.of(context);

  Search? searchModel = Search.empty();

  void search(String search) {
    emit(SearchLoadingState());
    DioHelper.postShopData(
            endPoint: SEARCH,
            data: {'text': search},
            token: Helper.getCurrenToken())
        .then((value) {
      searchModel = Search.fromJson(value.data);
      // print("Search: ${searchModel!.data!.products!.length}");
      emit(SearchSuccessState());
    }).catchError((error) {
      print(("catchError: ${error.toString()}"));
      emit(SearchFailedState(error.toString()));
    });
  }
}
