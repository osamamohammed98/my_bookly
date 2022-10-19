import 'package:bloc_basic/layout/news/cubit/cubit.dart';
import 'package:bloc_basic/layout/news/cubit/news_state.dart';
import 'package:bloc_basic/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsHomLayout extends StatelessWidget {
  const NewsHomLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusinessData()..getScience()..getSports(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.instance(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.brightness_6),
                  onPressed: () async => await AppCubit.instance(context).changeTheme(),
                ),
              ],
            ),
            body:cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(currentIndex: cubit.currentIndex,items: cubit.bottomItems,onTap: cubit.changeBottomNavBar,),
          );
        },

      ),
    );
  }
}
