import 'package:dartz/dartz.dart';

import '../../../../../core/firebase/service/interfaces/i_read_history_service.dart';
import '../../models/remove_read_history_model.dart';
import '../../../../../core/data/error/failure.dart';
import '../../../../../core/domain/dto/shelf_item_dto.dart';
import '../../../../../core/domain/usecase/base_use_case.dart';

class DeleteReadHistoryUsecase
    extends BaseUseCase<ShelfItemDto, RemoveReadHistoryModel> {
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
