import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/layout/todo_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/todo_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var listTasksDone = AppCubit.getCubit(context).listTasksDone;
        return ConditionEmptyBuilder(listTask: listTasksDone);
      },
    );
  }
}
