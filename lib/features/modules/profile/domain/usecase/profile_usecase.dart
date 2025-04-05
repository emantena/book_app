import 'package:book_app/core/data/error/failure.dart';
import 'package:book_app/core/domain/usecase/base_use_case.dart';
import 'package:book_app/core/firebase/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/firebase/repository/interfaces/i_user_repository.dart';

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
