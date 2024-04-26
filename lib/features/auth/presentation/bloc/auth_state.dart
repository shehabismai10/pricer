part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final UserModel? user;

  AuthState({this.user});
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoggedIn extends AuthState {
  final UserModel userModel;

  LoggedIn({required this.userModel});

  @override
  UserModel? get user => userModel;
}

class LoggedOut extends AuthState {}

class UserCreated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
