part of 'auth_bloc.dart';

class AuthState {
  UserModel? user;
  String? message;
  LoginStatus? status;

  AuthState({this.user, this.message, this.status});

  AuthState.initialize()
      : user = null,
        message = null,
        status = LoginStatus.initial;

  AuthState copyWith({UserModel? user, String? message, LoginStatus? status}) {
    return AuthState(
        status: status ?? this.status,
        message: message ?? this.message,
        user: user ?? this.user);
  }
}

enum LoginStatus { initial, loading, loggedIn, loggedOut, userCreated, error }
