import 'package:bloc/bloc.dart';
import 'package:bloc_basic/helper/show_snack_bar.dart';
import 'package:bloc_basic/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit instance(context) =>
      BlocProvider.of<RegisterCubit>(context);

  String? email;
  String? password;



  Future<void> registerUserRequest() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }

  void registerUser(GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      try {
        await registerUserRequest();
        emit(RegisterSuccessState());
        Navigator.pushNamed(context, ChatPage.id);
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'weak-password') {
          showSnackBar(context, 'weak password');
          emit(RegisterFlierState('weak password'));
        } else if (ex.code == 'email-already-in-use') {
          showSnackBar(context, 'email already exists');
          emit(RegisterFlierState('email already exists'));
        }
      } catch (ex) {
        showSnackBar(context, 'there was an error');
        emit(RegisterFlierState('there was an error'));
      }

    } else {}
  }
}
