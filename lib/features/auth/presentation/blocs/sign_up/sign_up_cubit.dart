import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../data/models/create_user_model.dart';
import '../../../../../domain/usecases/sign_up_usecase.dart';
import '../../../../../domain/usecases/validations/birth_date.dart';
import '../../../../../domain/usecases/validations/email.dart';
import '../../../../../domain/usecases/validations/password.dart';
import '../../../../../domain/usecases/validations/user_name.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUsecase _signUpUsecase;

  SignUpCubit(this._signUpUsecase) : super(const SignUpState());

  Future<void> registerUser() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final createUserModel = CreateUserModel(
      name: state.name.value,
      email: state.email.value,
      password: state.password.value,
      birthDate: state.birthDate.value,
    );

    final result = await _signUpUsecase(createUserModel);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
        ),
      ),
    );
  }

  // setters
  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          state.name,
          email,
          state.password,
          state.birthDate,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
          password: password,
          isValid: Formz.validate([
            state.name,
            state.email,
            password,
            state.birthDate,
          ])),
    );
  }

  void nameChanged(String value) {
    final name = UserName.dirty(value);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([
          name,
          state.email,
          state.password,
          state.birthDate,
        ]),
      ),
    );
  }

  void birthDateChanged(String value) {
    final birthDate = BirthDate.dirty(value);
    emit(
      state.copyWith(
        birthDate: birthDate,
        isValid: Formz.validate([
          state.name,
          state.email,
          state.password,
          birthDate,
        ]),
      ),
    );
  }
}
