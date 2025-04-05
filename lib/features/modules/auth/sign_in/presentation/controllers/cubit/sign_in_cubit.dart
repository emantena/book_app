import 'package:book_app/features/modules/auth/sign_in/data/models/sign_in_model.dart';
import 'package:book_app/features/modules/auth/sign_in/domain/usecase/sign_in_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../../core/domain/usecase/base_use_case.dart';
import '../../../../../search/domain/usecases/category_list_usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUsecase _signInUsecase;
  final CategoryListUseCase _categoryListInUsecase;
  
  SignInCubit(this._signInUsecase, this._categoryListInUsecase) : super(const SignInState());

  Future<void> signIn() async {
    if (state.email == null || state.password == null) {
      emit(state.copyWith(
        errorMessage: 'Preencha todos os campos',
        status: FormzSubmissionStatus.failure,
      ));
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final signInModel = SignInModel(email: state.email!, password: state.password!);
    final result = await _signInUsecase(signInModel);

    await _categoryListInUsecase(const NoParameters());

    result.fold(
      (l) => emit(state.copyWith(errorMessage: l.message, status: FormzSubmissionStatus.failure)),
      (r) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
    );
  }

  Future<void> emailChanged(String email) async {
    emit(state.copyWith(
      email: email,
      status: FormzSubmissionStatus.initial,
    ));
  }

  Future<void> passwordChanged(String password) async {
    emit(
      state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
      ),
    );
  }
}
