import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import 'base_use_case.dart';
import '../interfaces/repositories/i_authentication_repository.dart';
import '../interfaces/repositories/i_user_repository.dart';
import '../../core/error/failure.dart';
import '../../core/error/firebase_exceptions/sign_up_with_email_and_password_failure.dart';
import '../../data/models/create_user_model.dart';

class SignUpUsecase extends BaseUseCase<bool, CreateUserModel> {
  final IAuthenticationRepository _authRepository;
  final IUserRepository _userRepository;

  SignUpUsecase(this._authRepository, this._userRepository);

  @override
  Future<Either<Failure, bool>> call(CreateUserModel p) async {
    try {
      // Tenta registrar o usuário no serviço de autenticação
      final result = await _authRepository.register(p.email, p.password);

      if (result == null) {
        return const Left(
          DatabaseFailure('Ocorreu um erro inesperado'),
        );
      }

      // Converte a string de data de nascimento para DateTime
      final birthDate = DateFormat('dd/MM/yyyy').parse(p.birthDate);

      // Cria o perfil de usuário completo
      await _userRepository.createUser(result.id, p.email, p.name, birthDate);

      return const Right(true);
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      // Captura exceções específicas de registro
      return Left(DatabaseFailure(e.message));
    } catch (_) {
      // Para outros erros, tenta remover o usuário que foi parcialmente criado
      await _authRepository.remove();
      return const Left(DatabaseFailure('Ocorreu um erro inesperado'));
    }
  }
}
