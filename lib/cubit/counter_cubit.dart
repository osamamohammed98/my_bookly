import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  static CounterCubit instance(context) => BlocProvider.of<CounterCubit>(context);

  int teamAPoints = 0;

  int teamBPoints = 0;

  void addOnePoint() {
    if (kDebugMode) {
      print('add one point');
    }
  }

  void addOnTeamEPoints(int i) {
    teamAPoints=i;
    if (kDebugMode) {
      print(teamAPoints);
    }
    emit(CounterEIncrementState());
  }

  void addOnTeamBPoints(int i) {
    teamBPoints=i;
    if (kDebugMode) {
      print(teamBPoints);
    }
    emit(CounterBIncrementState());
  }

  void resetPoints() {
    teamAPoints = 0;
    teamBPoints = 0;
    emit(CounterResetState());
  }

}
