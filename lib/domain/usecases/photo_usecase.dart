import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/error/failure.dart';
import '../interfaces/repositories/i_user_repository.dart';
import 'base_use_case.dart';

class PhotoUsecase extends BaseUseCase<NoParameters, XFile> {
  final IUserRepository _userRepository;

  PhotoUsecase(this._userRepository);

  @override
  Future<Either<Failure, NoParameters>> call(XFile p) async {
    await _userRepository.addPhoto(p);

    return const Right(NoParameters());
  }
}
