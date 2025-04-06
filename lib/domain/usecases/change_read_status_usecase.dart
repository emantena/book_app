import 'package:dartz/dartz.dart';

import '../../core/data/error/failure.dart';
import '../interfaces/repositories/i_shelf_item_service.dart';
import 'base_use_case.dart';
import '../../data/models/change_read_status_request.dart';
import '../../data/models/dto/shelf_item_dto.dart';

class ChangeReadStatusUsecase extends BaseUseCase<ShelfItemDto, ChangeReadStatusRequest> {
  final IShelfItemService _shelfItemService;

  ChangeReadStatusUsecase(this._shelfItemService);

  @override
  Future<Either<Failure, ShelfItemDto>> call(ChangeReadStatusRequest p) async {
    try {
      var result = await _shelfItemService.updateReadStatus(p.bookId, p.readingStatus);
      return Right(result!);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
