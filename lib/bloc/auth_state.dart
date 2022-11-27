part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoadingStateBloc extends AuthState {}

class LoginSuccessStateBloc extends AuthState {}

class LoginFlierStateBloc extends AuthState {
  final String error;

  LoginFlierStateBloc(this.error);
}

class RegisterLoadingStateBloc extends AuthState {}

class RegisterSuccessStateBloc extends AuthState {}

class RegisterFlierStateBloc extends AuthState {
  final String error;

  RegisterFlierStateBloc(this.error);
}
