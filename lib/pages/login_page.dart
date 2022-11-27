import 'dart:ffi';
import 'dart:math';

import 'package:bloc_basic/bloc/auth_bloc.dart';
import 'package:bloc_basic/cubit/login/login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:bloc_basic/constants.dart';
import 'package:bloc_basic/helper/show_snack_bar.dart';
import 'package:bloc_basic/pages/resgister_page.dart';
import 'package:bloc_basic/widgets/custom_button.dart';
import 'package:bloc_basic/widgets/custom_text_field.dart';

import 'chat_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey();
  static String id = 'login page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var loginCubit = AuthBloc.instance(context);
          return ModalProgressHUD(
            inAsyncCall: state is LoginLoadingStateBloc,
            child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 75,
                      ),
                      Image.asset(
                        'assets/images/scholar.png',
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Scholar Chat',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontFamily: 'pacifico',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 75,
                      ),
                      Row(
                        children: const [
                          Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormTextField(
                        onChanged: (data) => loginCubit.email = data,
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormTextField(
                        obscureText: true,
                        onChanged: (data) => loginCubit.password = data,
                        hintText: 'Password',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButon(
                        onTap: () async =>
                            loginCubit.add(LoginEvent(
                            loginCubit.email!,
                            loginCubit.password!,
                            formKey,
                            context)),
                        text: 'LOGIN',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'dont\'t have an account?',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterPage.id);
                            },
                            child: const Text(
                              '  Register',
                              style: TextStyle(
                                color: Color(0xffC7EDE6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
