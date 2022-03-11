import 'package:bmi_calculator/modules/todo/archive_tasks/archived_tasks_screen.dart';
import 'package:bmi_calculator/modules/todo/done_tasks/done_tasks_screen.dart';
import 'package:bmi_calculator/modules/todo/new_tasks/new_tasks_screen.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/layout/todo_app/cubit/cubit.dart';
import 'package:bmi_calculator/layout/todo_app/cubit/states.dart';
import 'package:bmi_calculator/shared/network/local/db_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodoHomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is InsertToDatabaseState) Navigator.pop(context);
        },
        builder: (context, state) {
          AppCubit appCubit = AppCubit.getCubit(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
                title: Text(appCubit.listTitles[appCubit.currentNavIndex])),
            body: ConditionalBuilder(
                condition: state is! LoadingDatafromDatabseState,
                builder: (_) => appCubit.listScreens[appCubit.currentNavIndex],
                fallback: (_) => Center(child: CircularProgressIndicator())),
            floatingActionButton: FloatingActionButton.extended(
              label: Text("${appCubit.fabName}"),
              icon: Icon(appCubit.fabIcon),
              onPressed: () {
                if (appCubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    appCubit.insertToDB(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                    // dbHelpe!
                    //     .insertTaskToDB(
                    //     title: titleController.text,
                    //     time: timeController.text,
                    //     date: dateController.text)
                    //     .then((value) {
                    //   Navigator.pop(context);
                    //   dbHelpe!.getTasksFromDB()
                    //       .then((tasks) {
                    //     // setState(() {
                    //     //   isBottomSheetShown = false;
                    //     //   fabName = "New";
                    //     //   fabIcon = Icons.edit;
                    //     //   listTasks = tasks;
                    //     // });
                    //   });
                    // });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) => showBottomSheet(context),
                          elevation: 20.0)
                      .closed
                      .then((value) {
                    appCubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit, text: "New");
                  });
                  appCubit.changeBottomSheetState(
                      isShow: true, icon: Icons.add, text: "Add");
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: appCubit.currentNavIndex,
              onTap: (index) {
                appCubit.getCurrentNavIndex(index);
                // setState({() => currentNavIndex = index;)};
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
                BottomNavigationBarItem(icon: Icon(Icons.check_circle_rounded), label: "Done"),
                BottomNavigationBarItem(icon: Icon(Icons.archive_rounded,), label: "Archived"),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget showBottomSheet(context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomFormField(
              controller: titleController,
              keyboardType: TextInputType.text,
              lable: "Task Title",
              prefix: Icons.title,
              validate: (value) {
                if (value!.isEmpty) return "Please enter title";
                return null;
              },
            ),
            SizedBox(height: 14.0),
            CustomFormField(
              controller: timeController,
              keyboardType: TextInputType.none,
              lable: "Task Time",
              prefix: Icons.access_time,
              validate: (value) {
                if (value!.isEmpty) return "Please Select time";
                return null;
              },
              onTab: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then((value) {
                  if (value != null)
                    timeController.text = value.format(context);
                  else
                    timeController.text = "";
                }).catchError(
                        (error) => print("catchError: ${error.toString()}"));
              },
            ),
            SizedBox(height: 14.0),
            CustomFormField(
              controller: dateController,
              keyboardType: TextInputType.none,
              lable: "Task Date",
              prefix: Icons.date_range_rounded,
              validate: (value) {
                if (value!.isEmpty) return "Please Select date";
                return null;
              },
              onTab: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.utc(2025))
                    .then((value) {
                  if (value != null) {
                    dateController.text = DateFormat.yMMMd().format(value);
                    print("intl: " + DateFormat.yMMMd().format(value));
                    print("dateFormat: " +
                        formatDate(value, [d, '/', MM, '/', yyyy]));
                  } else
                    dateController.text = "";
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
