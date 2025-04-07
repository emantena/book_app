import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/user_model.dart';
import '../interfaces/repositories/i_user_repository.dart';
import 'base_use_case.dart';

class ProfileUsecase extends BaseUseCase<UserModel, NoParameters> {
  final IUserRepository _userRepository;

  ProfileUsecase(this._userRepository);

  @override
  Future<Either<Failure, UserModel>> call(p) async {
    final user = await _userRepository.getUser();

    if (user != UserModel.empty) return Right(user);

    return const Left(DatabaseFailure('Ocorreu um erro inesperado'));
  }
}
