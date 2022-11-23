import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bloc_basic/layout/cubit/social_cubit.dart';
import 'package:bloc_basic/layout/cubit/social_state.dart';
import 'package:bloc_basic/model/social_user_model.dart';
import 'package:bloc_basic/modules/chat_details/chat_details_screen.dart';
import 'package:bloc_basic/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return AnimatedConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(SocialCubit.get(context).users[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context) => const Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
    onTap: () {
      navigateTo(
        context,
        ChatDetailsScreen(
          userModel: model,
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            '${model.name}',
            style:const TextStyle(
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}