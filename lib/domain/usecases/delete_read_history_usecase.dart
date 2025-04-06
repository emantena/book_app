import 'package:dartz/dartz.dart';

import 'base_use_case.dart';
import '../interfaces/repositories/i_read_history_service.dart';
import '../../core/data/error/failure.dart';
import '../../data/models/dto/shelf_item_dto.dart';
import '../../data/models/remove_read_history_model.dart';

class DeleteReadHistoryUsecase extends BaseUseCase<ShelfItemDto, RemoveReadHistoryModel> {
  final IReadHistoryService _service;

  DeleteReadHistoryUsecase(this._service);

  @override
  Future<Either<Failure, ShelfItemDto>> call(RemoveReadHistoryModel p) async {
    try {
      var result = await _service.removeReadHistory(p.bookId, p.historyId);

      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
