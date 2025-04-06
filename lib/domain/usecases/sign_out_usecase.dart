import 'package:dartz/dartz.dart';

import 'base_use_case.dart';
import '../interfaces/repositories/i_authentication_repository.dart';
import '../../core/data/error/failure.dart';
import '../../core/firebase/exceptions/log_out_failure.dart';

class SignOutUsecase extends BaseUseCase<NoParameters, NoParameters> {
  final IAuthenticationRepository _authRepository;

  SignOutUsecase(this._authRepository);

  @override
  Future<Either<Failure, NoParameters>> call(NoParameters p) async {
    try {
      await _authRepository.logOut();
      return const Right(NoParameters());
    } on LogOutFailure catch (_) {
      return const Left(DatabaseFailure('Ocorreu um erro inesperado'));
    } catch (_) {
      return const Left(DatabaseFailure('Ocorreu um erro inesperado'));
    }
  }
}
