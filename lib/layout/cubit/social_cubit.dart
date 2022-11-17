import 'package:bloc_basic/layout/cubit/social_state.dart';
import 'package:bloc_basic/model/social_user_model.dart';
import 'package:bloc_basic/shared/components/constants.dart';
import 'package:bloc_basic/shared/network/local/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData()
  async{
    emit(SocialGetUserLoadingState());
    CacheHelper.getUserId();
   await FirebaseFirestore.instance
        .collection(USERS_COLLECTIONS)
        .doc(CacheHelper.getUserId())
        .get()
        .then((value)
    {
      model = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    })
        .catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialGetUserErrorState(error.toString()));

    });
  }
}
