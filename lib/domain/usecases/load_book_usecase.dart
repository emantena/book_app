import 'package:dartz/dartz.dart';

import '../../../../../core/data/error/failure.dart';
import '../../data/models/dto/shelf_item_dto.dart';
import '../interfaces/repositories/i_shelf_item_service.dart';
import 'base_use_case.dart';

class LoadBookUsecase extends BaseUseCase<ShelfItemDto, String> {
  final IShelfItemService _shelfItemservice;

  LoadBookUsecase(this._shelfItemservice);

  @override
  Future<Either<Failure, ShelfItemDto>> call(String p) async {
    try {
      var result = await _shelfItemservice.getShelfItemById(p);

      return Right(result!);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
