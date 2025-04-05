import 'package:book_app/core/data/error/failure.dart';
import 'package:book_app/core/domain/usecase/base_use_case.dart';
import 'package:book_app/core/firebase/repository/interfaces/i_user_repository.dart';
import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

class PhotoUsecase extends BaseUseCase<NoParameters, XFile> {
  final IUserRepository _userRepository;

  PhotoUsecase(this._userRepository);

  @override
  Future<Either<Failure, NoParameters>> call(XFile p) async {
    await _userRepository.addPhoto(p);

    return const Right(NoParameters());
  }
}
