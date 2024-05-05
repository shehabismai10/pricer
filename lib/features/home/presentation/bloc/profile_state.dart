part of 'profile_bloc.dart';

class ProfileState {
  ProfileStatus? status;
  String? message;

  ProfileState({this.status, this.message});

  ProfileState.initialize()
      : status = null,
        message = '';

  ProfileState copyWith({ProfileStatus? status, String? message}) {
    return ProfileState(
        message: message ?? this.message, status: status ?? this.status);
  }
}

enum ProfileStatus { initial, loading, error, updated }
