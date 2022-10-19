import 'package:bloc/bloc.dart';
import 'package:bloc_basic/layout/news/cubit/news_state.dart';
import 'package:bloc_basic/modules/business/business_view.dart';
import 'package:bloc_basic/modules/science/science_view.dart';
import 'package:bloc_basic/modules/settings_screen/settings_view.dart';
import 'package:bloc_basic/modules/sports/sport_view.dart';
import 'package:bloc_basic/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit instance(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if(index == 1) {
      getSports();
    }
    if(index == 2) {
      getScience();
    }
    emit(NewsBottomNavBarState());
  }

  List<dynamic> business = [];

  getBusinessData() async {
    emit(NewsBusinessLoadingState());
    // await Future.delayed(const Duration(seconds: 2));
    if(business.isEmpty) {
      await DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apikey': '00eb0d296dae465dab028e13a007c587',
      }).then((value) {
        business = value.data['articles'];
        emit(NewsBusinessSuccessState());
      }).catchError((onError) {
        emit(NewsBusinessFailState(onError.toString()));
      });
    }else{
      emit(NewsBusinessSuccessState());
    }
  }


  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsSportLoadingState());

    if(sports.isEmpty)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'sports',
          'apiKey':'00eb0d296dae465dab028e13a007c587',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];

        emit(NewsSportSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsSportFailState(error.toString()));
      });
    } else
    {
      emit(NewsSportSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsScienceLoadingState());

    if(science.isEmpty)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'science',
          'apiKey':'00eb0d296dae465dab028e13a007c587',
        },
      ).then((value)
      {
        science = value.data['articles'];

        emit(NewsScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsScienceFailState(error.toString()));
      });
    } else
    {
      emit(NewsScienceSuccessState());
    }
  }


 List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q':value,
        'apiKey':'00eb0d296dae465dab028e13a007c587',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsSearchErrorState(error.toString()));
    });
  }

}
