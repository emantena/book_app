part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final FormzSubmissionStatus status;
  final Email email;
  final bool isValid;
  final String? errorMessage;

  const ForgotPasswordState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.isValid = false,
    this.errorMessage = '',
  });

  ForgotPasswordState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    String? errorMessage,
    bool? isValid,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        isValid,
        errorMessage,
      ];
}
