part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}
class Login extends AuthEvent{
 final String email;
 final String password;

  Login({required this.email, required this.password});
}

 class Register extends  AuthEvent{
  final String email;
  final String password;
  final String name;
  Register({required this.email, required this.password, required this.name});
 }