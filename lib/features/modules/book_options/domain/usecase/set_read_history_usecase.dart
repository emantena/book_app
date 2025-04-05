import 'package:dartz/dartz.dart';

import '../../../../../core/data/error/failure.dart';
import '../../../../../core/domain/dto/read_history_dto.dart';
import '../../../../../core/domain/dto/shelf_item_dto.dart';
import '../../../../../core/domain/usecase/base_use_case.dart';
import '../../../../../core/firebase/service/interfaces/i_read_history_service.dart';

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
