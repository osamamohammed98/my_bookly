import 'package:bloc_basic/shared/cubit/state.dart';
import 'package:bloc_basic/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitState());

  static AppCubit instance(context) => BlocProvider.of(context);


  bool isDark = false;



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
