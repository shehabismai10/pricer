part of 'auth_bloc.dart';

class AuthState {
  UserModel? user;
  String? message;
  AuthStatus? status;

  AuthState({this.user, this.message, this.status});

  AuthState.initialize()
      : user = null,
        message = null,
        status = AuthStatus.initial;

  AuthState copyWith({UserModel? user, String? message, AuthStatus? status}) {
    return AuthState(
        status: status ?? this.status,
        message: message ?? this.message,
        user: user ?? this.user);
  }
}

enum AuthStatus { initial, loading, loggedIn, loggedOut, userCreated, error }
