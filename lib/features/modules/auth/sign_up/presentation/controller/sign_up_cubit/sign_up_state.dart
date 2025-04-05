part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final UserName name;
  final BirthDate birthDate;
  final bool isValid;
  final String? errorMessage;

  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.name = const UserName.pure(),
    this.birthDate = const BirthDate.pure(),
    this.isValid = false,
    this.errorMessage = '',
  });

  SignUpState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    UserName? name,
    BirthDate? birthDate,
    String? errorMessage,
    bool? isValid,
  }) {
    return SignUpState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      errorMessage: errorMessage ?? this.errorMessage,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        name,
        birthDate,
        isValid,
        errorMessage,
      ];
}
