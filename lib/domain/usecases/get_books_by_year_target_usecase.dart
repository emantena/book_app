import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/dto/shelf_item_dto.dart';
import '../interfaces/services/i_read_meta_service.dart';
import 'base_use_case.dart';

class GetBooksByYearTargetUsecase extends BaseUseCase<List<ShelfItemDto>, int?> {
  final IReadMetaService _readMetaService;

  GetBooksByYearTargetUsecase(this._readMetaService);

  @override
  Future<Either<Failure, List<ShelfItemDto>>> call(int? p) async {
    try {
      final books = await _readMetaService.getBooksByYearTarget(p);
      return Right(books);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
