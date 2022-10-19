import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bloc_basic/layout/news/cubit/cubit.dart';
import 'package:bloc_basic/layout/news/cubit/news_state.dart';
import 'package:bloc_basic/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.instance(context);
        return articleBuilder(cubit.business , context)
        /*AnimatedConditionalBuilder(
          condition: state is! NewsBusinessLoadingState,
          builder: (BuildContext context) {
            return AnimatedConditionalBuilder(
              condition: state is NewsBusinessSuccessState &&
                  cubit.business.isNotEmpty,
              builder: (BuildContext context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildArticleItem(cubit.business[index]),
                separatorBuilder: (BuildContext context, int index) => myDivider(),
                itemCount: cubit.business.length,
                shrinkWrap: true,
              ),
              fallback: (BuildContext context) => const Center(
                child: Text(
                  'Empty State',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          fallback: (BuildContext context) => const Center(
            child: CupertinoActivityIndicator(),
          ),
        )*/
            ;
      },
    );
  }
}
