import 'package:bloc_basic/cubit/register/register_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:bloc_basic/constants.dart';
import 'package:bloc_basic/helper/show_snack_bar.dart';
import 'package:bloc_basic/pages/chat_page.dart';
import 'package:bloc_basic/widgets/custom_button.dart';
import 'package:bloc_basic/widgets/custom_text_field.dart';


class RegisterPage extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  static String id = 'RegisterPage';
  RegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var registerCubit = RegisterCubit.instance(context);
          return ModalProgressHUD(
            inAsyncCall: state is RegisterLoadingState,
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
                            'REGISTER',
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
                        onChanged: (data) => registerCubit.email = data,
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormTextField(
                        onChanged: (data) => registerCubit.password = data,
                        hintText: 'Password',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButon(
                        onTap: () async =>
                            registerCubit.registerUser(formKey, context),
                        text: 'REGISTER',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'already have an account?',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              '  Login',
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
