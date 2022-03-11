import 'package:bmi_calculator/modules/todo/archive_tasks/archived_tasks_screen.dart';
import 'package:bmi_calculator/modules/todo/done_tasks/done_tasks_screen.dart';
import 'package:bmi_calculator/modules/todo/new_tasks/new_tasks_screen.dart';
import 'package:bmi_calculator/layout/todo_app/cubit/states.dart';
import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/network/local/cache_helper.dart';
import 'package:bmi_calculator/shared/network/local/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  DBHelper dbHelper = DBHelper();
  bool isDark = false;
  IconData darkModeIcon = Icons.brightness_4_outlined;
  List<Map> listTasksNew = [];
  List<Map> listTasksDone = [];
  List<Map> listTasksArchived = [];
  int currentNavIndex = 0;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  String fabName = "New";

  List<Widget> listScreens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];
  List<String> listTitles = ["New Tasks", "Done Tasks", "Archived Tasks"];

  static AppCubit getCubit(context) => BlocProvider.of(context);

  void changeThemeApp({bool? darkMode}) {
    if (darkMode != null) {
      isDark = darkMode;
      emit(ThemeAppModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveDarkMode(key: Const.KEY_DARK_MODE, value: isDark)
          .then((value) => emit(ThemeAppModeState()));
    }
  }

  void getCurrentNavIndex(int currentNavIndex) {
    this.currentNavIndex = currentNavIndex;
    emit(ChangeBottomNavState());
  }

  // Create database
  void createDB() {
    dbHelper.createDatabase().then((db) {
      DBHelper.database = db;
      emit(CreateDatabaseState());
      getTasksNew();
      getTasksDone();
      getTasksArchived();
    });
  }

  // Add task
  void insertToDB({
    required String title,
    required String time,
    required String date,
  }) {
    dbHelper.insertTaskToDB(title: title, time: time, date: date);
    emit(InsertToDatabaseState());
    getTasksNew();
    getTasksDone();
    getTasksArchived();
  }

  // Update task
  void updateTask({required String status, required int id}) {
    dbHelper.updateTask(status: status, id: id).then((value) {
      emit(UpdateDataState());
      getTasksNew();
      getTasksDone();
      getTasksArchived();
    });
  }

  // Delete task
  void deleteTask({required int id}) {
    dbHelper.deleteTask(id: id).then((value) {
      emit(DeleteDataState());
      getTasksNew();
      getTasksDone();
      getTasksArchived();
    });
  }

  // All Tasks
  void getTasks() {
    dbHelper.getTasksFromDB().then((tasks) {
      emit(LoadingDatafromDatabseState());
      listTasksNew = tasks;
      print("Size: ${listTasksNew.length}");
      print("listTasks: $listTasksNew");
      emit(GetFromDatabaseState());
    });
  }

  // Course example
  void getAllTasks() {
    dbHelper.getTasksFromDB().then((tasks) {
      emit(LoadingDatafromDatabseState());
      tasks.forEach((element) {
        if (element['status'] == "New")
          listTasksNew.add(element);
        else if (element['status'] == "Done")
          listTasksDone.add(element);
        else
          listTasksArchived.add(element);
      });
      emit(GetFromDatabaseState());
    });
  }

  // Get all new tasks
  void getTasksNew() {
    dbHelper.getTasksNew().then((tasksNew) {
      emit(LoadingDatafromDatabseState());
      listTasksNew = tasksNew;
      print("Size: ${listTasksNew.length}");
      print("listTasksNew: $listTasksNew");
      emit(GetDoneStatusState());
    });
  }

  // Get all done tasks
  void getTasksDone() {
    dbHelper.getTasksDone().then((tasksDone) {
      emit(LoadingDatafromDatabseState());
      listTasksDone = tasksDone;
      print("Size: ${listTasksDone.length}");
      print("listTasksDone: $listTasksDone");
      emit(GetDoneStatusState());
    });
  }

  // Get all archuved tasks
  void getTasksArchived() {
    dbHelper.getTasksArchived().then((tasksArchived) {
      emit(LoadingDatafromDatabseState());
      listTasksArchived = tasksArchived;
      print("Size: ${listTasksArchived.length}");
      print("listTasksArchived: $listTasksArchived");
      emit(GetArchivedStatusState());
    });
  }

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
    required String text,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    fabName = text;
    emit(ChangeBottomSheetState());
  }

  void changeDarkMode({
    required bool isDark,
    required IconData darkModeIcon,
  }) {
    this.isDark = isDark;
    this.darkModeIcon = darkModeIcon;;
    emit(ChangeDarkModeState());
  }
}
