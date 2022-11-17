import 'package:bloc_basic/modules/social_login/social_login_screen.dart';
import 'package:bloc_basic/shared/components/components.dart';
import 'package:bloc_basic/shared/network/local/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

void signOut(context) {
  FirebaseAuth.instance.signOut();
  CacheHelper.clear().then((value) {
    navigateAndFinish(context, SocialLoginScreen());
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) {
    if (kDebugMode) {
      print(match.group(0));
    }
  });
}

// String uId = '';

const String USERS_COLLECTIONS = "users_social";
