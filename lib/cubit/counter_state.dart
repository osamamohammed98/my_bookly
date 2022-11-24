part of 'counter_cubit.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterEIncrementState extends CounterState{}
class CounterBIncrementState extends CounterState{}
class CounterResetState extends CounterState{}
