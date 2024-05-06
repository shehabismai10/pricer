import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pricer/core/serviceLocator/service_locator.dart';
import 'package:pricer/features/auth/data/entity/user_model.dart';
import 'package:pricer/features/auth/data/repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initialize()) {
    on<Login>(onLogin);
    on<Register>(onRegister);
    on<Logout>(onLogout);
  }

  final authLocator = serviceLocator<AuthRepositoryImplementation>();

  void onLogin(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result =
        await authLocator.login(email: event.email, password: event.password);
    result.fold((l) => emit(AuthState(message: l.message,status: AuthStatus.error)),
        (r) => emit(AuthState(user: r,status: AuthStatus.loggedIn)));
  }

  void onRegister(Register event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await authLocator.register(
        email: event.email, password: event.password, name: event.name);
    result.fold(
        (l) => emit(AuthState(message: l.message,status: AuthStatus.error)), (r) => emit(AuthState(status: AuthStatus.userCreated)));
  }

  void onLogout(Logout event,Emitter<AuthState>emit){
final result=    authLocator.logout();
result.fold(
        (l) => emit(AuthState(message: l.message,status: AuthStatus.error)), (r) => emit(AuthState(status: AuthStatus.loggedOut)));

  }
}
