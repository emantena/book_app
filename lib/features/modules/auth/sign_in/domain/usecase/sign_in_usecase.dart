import 'package:book_app/core/data/error/failure.dart';
import 'package:book_app/core/domain/usecase/base_use_case.dart';
import 'package:book_app/core/firebase/exceptions/sign_in_failure.dart';
import 'package:book_app/core/firebase/repository/interfaces/i_authentication_repository.dart';
import 'package:book_app/core/firebase/repository/interfaces/i_user_repository.dart';
import 'package:book_app/features/modules/auth/sign_in/data/models/sign_in_model.dart';
import 'package:dartz/dartz.dart';

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
