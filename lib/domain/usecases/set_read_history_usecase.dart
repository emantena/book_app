import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/dto/read_history_dto.dart';
import '../../data/models/dto/shelf_item_dto.dart';
import '../interfaces/services/i_read_history_service.dart';
import 'base_use_case.dart';

class SetReadHistoryUsecase extends BaseUseCase<ShelfItemDto, ReadHistoryDto> {
  final IReadHistoryService _service;

  SetReadHistoryUsecase(this._service);

  @override
  Future<Either<Failure, ShelfItemDto>> call(ReadHistoryDto p) async {
    try {
      var result = await _service.setReadHistory(p);

      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
