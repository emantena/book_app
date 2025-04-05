import 'package:book_app/core/domain/validations/email.dart';
import 'package:book_app/features/modules/auth/forgot_password/data/models/forgot_password_model.dart';
import 'package:book_app/features/modules/auth/forgot_password/domain/usecase/forgot_password_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUsecase _forgotPasswordUsecase;

  ForgotPasswordCubit(this._forgotPasswordUsecase) : super(const ForgotPasswordState());

  Future<void> forgotPasswordSendMail() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final forgotPasswordModel = ForgotPasswordModel(
      email: state.email.value,
    );

    final result = await _forgotPasswordUsecase(forgotPasswordModel);

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
          email,
        ]),
      ),
    );
  }
}
