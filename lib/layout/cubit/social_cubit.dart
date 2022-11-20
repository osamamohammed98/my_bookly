import 'package:bloc_basic/layout/cubit/social_state.dart';
import 'package:bloc_basic/model/social_user_model.dart';
import 'package:bloc_basic/modules/chats/chat_screen.dart';
import 'package:bloc_basic/modules/feeds/feeda_screen.dart';
import 'package:bloc_basic/modules/new_posts/new_post_screen.dart';
import 'package:bloc_basic/modules/settings/settings_screen.dart';
import 'package:bloc_basic/modules/users/users_screen.dart';
import 'package:bloc_basic/shared/components/constants.dart';
import 'package:bloc_basic/shared/network/local/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData() {
    if(FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.uid != null){
      emit(SocialGetUserLoadingState());

      FirebaseFirestore.instance
          .collection(USERS_COLLECTIONS)
          .doc(CacheHelper.getUserId())
          .get()
          .then((value) {
        if (kDebugMode) {
          print(value.data());
        }
        model = SocialUserModel.fromJson(value.data()!);
        emit(SocialGetUserSuccessState());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(SocialGetUserErrorState(error.toString()));
      });
    }

  }

  int currentIndex = 0;

  List<Widget> screens = const [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }
}
