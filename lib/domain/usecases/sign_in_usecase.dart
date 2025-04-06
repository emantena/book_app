import 'package:dartz/dartz.dart';

import 'base_use_case.dart';
import '../interfaces/repositories/i_authentication_repository.dart';
import '../interfaces/repositories/i_user_repository.dart';
import '../../core/data/error/failure.dart';
import '../../core/firebase/exceptions/sign_in_failure.dart';
import '../../data/models/sign_in_model.dart';

class SignInUsecase extends BaseUseCase<bool, SignInModel> {
  final IAuthenticationRepository _authRepository;
  final IUserRepository _userRepository;

  SignInUsecase(this._authRepository, this._userRepository);

  @override
  Future<Either<Failure, bool>> call(SignInModel p) async {
    try {
      final result = await _authRepository.login(p.email, p.password);

      if (result == null) {
        return const Left(
          DatabaseFailure('email ou senha inválidos'),
        );
      }

      await _userRepository.getUser();

      return const Right(true);
    } on SignInFailure catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (_) {
      return const Left(DatabaseFailure('Ocorreu um erro inesperado'));
    }
  }
}
