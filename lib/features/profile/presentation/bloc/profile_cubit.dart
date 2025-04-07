import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/user_model.dart';
import '../../../../domain/usecases/base_use_case.dart';
import '../../../../domain/usecases/photo_usecase.dart';
import '../../../../domain/usecases/profile_usecase.dart';
import '../../../../domain/usecases/sign_out_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SignOutUsecase _signOutUsecase;
  final ProfileUsecase _profileUseCase;
  final PhotoUsecase _photoUsecase;

  ProfileCubit(this._signOutUsecase, this._profileUseCase, this._photoUsecase) : super(const ProfileState()) {
    getUser();
  }

  Future<void> getUser() async {
    final result = await _profileUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileStatus.logout,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ProfileStatus.success,
          user: r,
        ),
      ),
    );
  }

  Future<void> signOut() async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      await _signOutUsecase(const NoParameters());
      emit(state.copyWith(status: ProfileStatus.logout));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updatePhoto(XFile photo) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      await _photoUsecase(photo);
      emit(state.copyWith(status: ProfileStatus.changePhoto));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
