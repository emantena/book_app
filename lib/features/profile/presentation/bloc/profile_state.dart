part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, success, logout, changePhoto, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final String? errorMessage;
  final UserModel? user;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.errorMessage,
    this.user = UserModel.empty,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    String? errorMessage,
    UserModel? user,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, user];
}
