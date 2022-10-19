import 'package:bloc/bloc.dart';
import 'package:bloc_basic/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:bloc_basic/modules/done_tasks/done_tasks_screen.dart';
import 'package:bloc_basic/modules/new_tasks/new_tasks_screen.dart';
import 'package:bloc_basic/shared/cubit/state.dart';
import 'package:bloc_basic/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitState());

  static AppCubit instance(context) => BlocProvider.of(context);

  int currentIndex = 0;
  Database? database;
  List<Map> tasks = [];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  bool isDark = false;

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() async {
    /*database = await*/ openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database opened');
        //getDatabase()
        getFromDatabase(
                database) /*.then((value) {
          tasks = value;
          emit(AppGetDatabaseState());
        })*/
            ;
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  /*Future? */
  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    /* return*/ await database!.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getFromDatabase(
                database!) /*.then((value)
        {
          tasks = value;
          emit(AppGetDatabaseState());



          changeBottomSheetState(
              isShow: false, icon: Icons.edit);
        })*/
            ;
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });

      return Future.value(null);
    });
  }

  /*Future<List<Map>>*/
  void getFromDatabase(Database database) async {
    emit(AppGetDatabaseLoadingState());
    // return await database.rawQuery("SELECT * FROM taska");
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });

      emit(AppGetDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getFromDatabase(database!);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getFromDatabase(database!);
      emit(AppDeleteDatabaseState());
    });
  }

  changeTheme({bool? fromShared}) async {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppThemeChangedState());
    } else {
      isDark = !isDark;
      await CacheHelper.putBoolean(value: isDark).then((value) {
        emit(AppThemeChangedState());
      });
    }
  }
}
