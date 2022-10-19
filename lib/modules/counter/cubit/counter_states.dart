abstract class CounterState{}

class CounterInitState extends CounterState{}

class CounterMinusState extends CounterState
{
  int counter;
  CounterMinusState(this.counter);
}

class CounterPlusState extends CounterState
{
  int counter;
  CounterPlusState(this.counter);
}