import 'package:bloc_basic/modules/counter/cubit/counter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState>
{
  CounterCubit() : super(CounterInitState());

  static CounterCubit instance(BuildContext context) => BlocProvider.of<CounterCubit>(context);

  int counter = 1;



  void onMinusClick(){
    if(counter == 0) return;
    counter--;
    emit(CounterMinusState(counter));
  }


  void onPlusClick(){
    counter++;
    emit(CounterPlusState(counter));
  }
}
