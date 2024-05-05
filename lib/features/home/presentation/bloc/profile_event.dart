part of 'profile_bloc.dart';

 abstract class ProfileEvent {}
class PickFile extends ProfileEvent{}
class UpdateProfile extends ProfileEvent{
  final UserModel userModel;

  UpdateProfile({required this.userModel});
}