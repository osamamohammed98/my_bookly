import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_basic/helper/show_snack_bar.dart';
import 'package:bloc_basic/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  String? email;
  String? password;


  static AuthBloc instance(BuildContext context) => BlocProvider.of<AuthBloc>(context);

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{
      // TODO: implement event handler
      if (event is LoginEvent) {
       await loginUser(event.formKey, event.context, event ,emit);
      } else if (event is RegisterEvent) {
        await registerUser(event.formKey, event.context, event ,emit);
      }
    });
  }

  Future<void> loginUser(GlobalKey<FormState> formKey, BuildContext context,
      LoginEvent event, Emitter<AuthState> emit) async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingStateBloc());
      try {
        await loginUserRequest(event);
        emit(LoginSuccessStateBloc());
        Navigator.pushNamed(context, ChatPage.id, arguments: event.email);
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'user-not-found') {
          showSnackBar(context, 'user not found');
          emit(LoginFlierStateBloc('user not found'));
        } else if (ex.code == 'wrong-password') {
          showSnackBar(context, 'wrong password');
          emit(LoginFlierStateBloc('wrong password'));
        }
      } catch (ex) {
        if (kDebugMode) {
          print(ex);
        }
        showSnackBar(context, 'there was an error');
        emit(RegisterFlierStateBloc('there was an error'));
      }
    } else {}
  }

  Future<void> loginUserRequest(LoginEvent event) async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: event.email, password: event.password);
  }

  Future<void> registerUserRequest(RegisterEvent event) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: event.email, password: event.password);
  }

  Future<void> registerUser(GlobalKey<FormState> formKey, BuildContext context,
      RegisterEvent event, Emitter<AuthState> emit) async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingStateBloc());
      try {
        await registerUserRequest(event);
        emit(RegisterSuccessStateBloc());
        Navigator.pushNamed(context, ChatPage.id);
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'weak-password') {
          showSnackBar(context, 'weak password');
          emit(RegisterFlierStateBloc('weak password'));
        } else if (ex.code == 'email-already-in-use') {
          showSnackBar(context, 'email already exists');
          emit(RegisterFlierStateBloc('email already exists'));
        }
      } catch (ex) {
        showSnackBar(context, 'there was an error');
        emit(RegisterFlierStateBloc('there was an error'));
      }
    } else {}
  }


  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
  }

}
