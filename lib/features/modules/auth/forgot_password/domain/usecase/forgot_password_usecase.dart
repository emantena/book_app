import 'package:book_app/core/data/error/failure.dart';
import 'package:book_app/core/domain/usecase/base_use_case.dart';
import 'package:book_app/core/firebase/exceptions/forgot_password_failure.dart';
import 'package:book_app/core/firebase/repository/interfaces/i_authentication_repository.dart';
import 'package:book_app/features/modules/auth/forgot_password/data/models/forgot_password_model.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordUsecase extends BaseUseCase<bool, ForgotPasswordModel> {
  final IAuthenticationRepository _authRepository;

  ForgotPasswordUsecase(this._authRepository);

  @override
  Future<Either<Failure, bool>> call(ForgotPasswordModel p) async {
    try {
      final result = await _authRepository.resetPassword(p.email);

      if (!result) {
        return const Left(
          DatabaseFailure('Ocorreu um erro inesperado'),
        );
      }

      return const Right(true);
    } on ForgotPasswordFailure catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (_) {
      return const Left(DatabaseFailure('Ocorreu um erro inesperado'));
    }
  }
}
