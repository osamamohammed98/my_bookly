import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bloc_basic/layout/cubit/social_cubit.dart';
import 'package:bloc_basic/layout/cubit/social_state.dart';
import 'package:bloc_basic/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News Feed',
            ),
          ),
          body: AnimatedConditionalBuilder(
            condition:  (SocialCubit.get(context).model != null )/* != null*/,
            builder: (context) {
              // var model = !(SocialCubit.get(context).model?.isEmailVerified ?? false );
              // if (kDebugMode) {
              //   print("test_ $model");
              // }

              return Column(
                children: [
                ],
              );
            },
            fallback: (context) =>
                const Center(child: CupertinoActivityIndicator()),
          ),
        );
      },
    );
  }
}
