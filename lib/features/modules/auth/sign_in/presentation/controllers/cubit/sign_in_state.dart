part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final FormzSubmissionStatus status;
  final String? email;
  final String? password;
  final String? errorMessage;

  const SignInState({
    this.status = FormzSubmissionStatus.initial,
    this.email,
    this.password,
    this.errorMessage,
  });

  SignInState copyWith({
    FormzSubmissionStatus? status,
    String? email,
    String? password,
    String? errorMessage,
  }) {
    return SignInState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        errorMessage,
      ];
}
