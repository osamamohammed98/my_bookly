import 'package:bloc_basic/layout/news/cubit/cubit.dart';
import 'package:bloc_basic/layout/news/cubit/news_state.dart';
import 'package:bloc_basic/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var list = NewsCubit.instance(context).sports;

        return articleBuilder(list , context);
      },
    );
  }
}