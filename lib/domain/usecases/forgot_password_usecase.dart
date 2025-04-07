import 'package:dartz/dartz.dart';

import 'base_use_case.dart';
import '../interfaces/repositories/i_authentication_repository.dart';
import '../../core/error/failure.dart';
import '../../core/error/firebase_exceptions/forgot_password_failure.dart';
import '../../data/models/forgot_password_model.dart';

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
