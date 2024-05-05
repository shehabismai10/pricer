import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pricer/core/serviceLocator/service_locator.dart';
import 'package:pricer/features/auth/data/entity/user_model.dart';
import 'package:pricer/features/home/data/repository/profileRepository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initialize()) {
    on<PickFile>(onPickFile);
    on<UpdateProfile>(onUpdateProfile);
  }

  final profileLocator = serviceLocator<ProfileRepositoryImplementation>();

  void onPickFile(PickFile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await profileLocator.pickFile();
    result.fold(
        (l) => emit(
            state.copyWith(status: ProfileStatus.error, message: l.message)),
        (r) => emit(
            state.copyWith(status: ProfileStatus.updated, message: r.message)));
  }

  void onUpdateProfile(UpdateProfile event,Emitter<ProfileState>emit)async{
    final result=await profileLocator.updateProfile(userModel: event.userModel);
    result.fold(
            (l) => emit(
            state.copyWith(status: ProfileStatus.error, message: l.message)),
            (r) => emit(
            state.copyWith(status: ProfileStatus.updated, message: r.message)));
  }

}
