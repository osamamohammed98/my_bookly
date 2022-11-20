
import 'package:bloc_basic/firebase_options.dart';
import 'package:bloc_basic/layout/cubit/social_cubit.dart';
import 'package:bloc_basic/layout/social_layout.dart';
import 'package:bloc_basic/modules/social_login/social_login_screen.dart';
import 'package:bloc_basic/shared/cubit/cubit.dart';
import 'package:bloc_basic/shared/cubit/state.dart';
import 'package:bloc_basic/shared/network/local/cache_helper.dart';
import 'package:bloc_basic/shared/network/remote/dio_helper.dart';
import 'package:bloc_basic/shared/observer.dart';
import 'package:bloc_basic/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool isDark = CacheHelper.getBoolean();
  bool isOnBoarding = CacheHelper.getOnBoarding();
  bool isLogin = CacheHelper.getOnLogin();
  runApp(MyApp(isDark: isDark, isOnBoarding: isOnBoarding,isLogin:isLogin));

}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  const MyApp( {super.key,required this.isDark, required this.isOnBoarding, required this.isLogin, });

  final bool isDark;
  final bool isOnBoarding;
  final  bool isLogin;

  // constructor
  // build

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeTheme(fromShared: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.instance(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home:  CacheHelper.getUserId().isNotEmpty ? SocialLayout():SocialLoginScreen()/*isOnBoarding ? isLogin ? const ShopLayoutView():ShopLoginScreen():const OnBoardingView ()*/,
          );
        },
      ),
    );
  }


}
