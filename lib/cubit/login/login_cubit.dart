import 'package:bloc/bloc.dart';
import 'package:bloc_basic/helper/show_snack_bar.dart';
import 'package:bloc_basic/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit instance(context) => BlocProvider.of<LoginCubit>(context);

  String? email;
  String? password;

  void loginUser(GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      try {
        await loginUserRequest();
        emit(LoginSuccessState());
        Navigator.pushNamed(context, ChatPage.id, arguments: email);
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'user-not-found') {
          showSnackBar(context, 'user not found');
          emit(LoginFlierState('user not found'));
        } else if (ex.code == 'wrong-password') {
          showSnackBar(context, 'wrong password');
          emit(LoginFlierState('wrong password'));
        }
      } catch (ex) {
        if (kDebugMode) {
          print(ex);
        }
        showSnackBar(context, 'there was an error');
        emit(LoginFlierState('there was an error'));
      }

    } else {}
  }

  Future<void> loginUserRequest() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
