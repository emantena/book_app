import 'package:dartz/dartz.dart';

import 'base_use_case.dart';
import '../interfaces/services/i_shelf_item_service.dart';
import '../../core/error/failure.dart';

class RemoveBookUsecase extends BaseUseCase<bool, String> {
  final IShelfItemService _shelfItemService;

  RemoveBookUsecase(this._shelfItemService);

  @override
  Future<Either<Failure, bool>> call(String p) async {
    try {
      await _shelfItemService.addRemoveBook(p);
      return const Right(true);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
