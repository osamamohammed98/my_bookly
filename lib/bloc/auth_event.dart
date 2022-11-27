part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final GlobalKey<FormState> formKey;
  final BuildContext context;

  LoginEvent(this.email, this.password, this.formKey, this.context);
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final GlobalKey<FormState> formKey;
  final BuildContext context;

  RegisterEvent(this.email, this.password, this.formKey, this.context);
}
