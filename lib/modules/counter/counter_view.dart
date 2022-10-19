import 'dart:math';

import 'package:bloc_basic/modules/counter/cubit/counter_cubit.dart';
import 'package:bloc_basic/modules/counter/cubit/counter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// state less contain one class provide widget

// state ful contain  classes

// 1. first class provide widget
// 2. second class provide state from this widget

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          if(state is CounterPlusState)  print("CounterPlusState ${state.counter}");
          if(state is CounterMinusState)  print("CounterMinusState ${state.counter}");
        },
        builder: (context, state) {
          CounterCubit counterCubit = CounterCubit.instance(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'counter',
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      counterCubit.onMinusClick();
                    },
                    child: const Text(
                      'MINUS',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Text(
                      '${counterCubit.counter}',
                      style: const TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      counterCubit.onPlusClick();
                    },
                    child: const Text(
                      'PLUS',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
