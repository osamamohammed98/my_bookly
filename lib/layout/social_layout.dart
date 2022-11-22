import 'package:bloc_basic/layout/cubit/social_cubit.dart';
import 'package:bloc_basic/layout/cubit/social_state.dart';
import 'package:bloc_basic/modules/new_posts/new_post_screen.dart';
import 'package:bloc_basic/shared/components/components.dart';
import 'package:bloc_basic/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    {
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialNewPostState) {
            navigateTo(
              context,
               const NewPostScreen(),
            );
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    IconBroken.Notification,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    IconBroken.Search,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                  ),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                  ),
                  label: 'Post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Location,
                  ),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                  ),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      );
    }
  }
}