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
            condition: SocialCubit.get(context).model != null,
            builder: (context) {
              var model = FirebaseAuth.instance.currentUser?.emailVerified;
              if (kDebugMode) {
                print(model);
              }

              return Column(
                children: [
                  if (!model!)
                    Container(
                      color: Colors.amber.withOpacity(.6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            const Expanded(
                              child: Text(
                                'please verify your email',
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            defaultTextButton(
                              onPress: () {
                                FirebaseAuth.instance.currentUser
                                    ?.sendEmailVerification()
                                    .then((value) {
                                  successToast(
                                    'check your mail',
                                  );
                                }).catchError((error) {});
                              },
                              txt: 'send',
                            ),
                          ],
                        ),
                      ),
                    ),
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
