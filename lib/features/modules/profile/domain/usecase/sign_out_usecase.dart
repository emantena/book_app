import 'package:book_app/core/data/error/failure.dart';
import 'package:book_app/core/domain/usecase/base_use_case.dart';
import 'package:book_app/core/firebase/exceptions/log_out_failure.dart';
import 'package:book_app/core/firebase/repository/interfaces/i_authentication_repository.dart';
import 'package:dartz/dartz.dart';

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
