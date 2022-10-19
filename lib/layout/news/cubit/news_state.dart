import 'package:bloc_basic/modules/new_tasks/new_tasks_screen.dart';

abstract class NewsStates {}

class NewsInitialState extends NewsStates{}
class NewsBottomNavBarState extends NewsStates{}

class NewsBusinessLoadingState extends NewsStates{}
class NewsBusinessSuccessState extends NewsStates{}
class NewsBusinessFailState extends NewsStates {
  String error;

  NewsBusinessFailState(this.error);
}



class NewsSportLoadingState extends NewsStates{}
class NewsSportSuccessState extends NewsStates{}
class NewsSportFailState extends NewsStates {
  String error;

  NewsSportFailState(this.error);
}



class NewsScienceLoadingState extends NewsStates{}
class NewsScienceSuccessState extends NewsStates{}
class NewsScienceFailState extends NewsStates {
  String error;

  NewsScienceFailState(this.error);
}


class NewsSearchLoadingState extends NewsStates{}
class NewsSearchSuccessState extends NewsStates{}
class NewsSearchErrorState extends NewsStates {
  String error;

  NewsSearchErrorState(this.error);
}