import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/read_meta_model.dart';
import '../interfaces/services/i_read_meta_service.dart';
import '../interfaces/services/i_shelf_item_service.dart';
import 'base_use_case.dart';

class SetReadMetaUsecase extends BaseUseCase<bool, SetReadMetaParams> {
  final IReadMetaService _readMetaService;
  final IShelfItemService _shelfItemService;

  SetReadMetaUsecase(this._readMetaService, this._shelfItemService);

  @override
  Future<Either<Failure, bool>> call(SetReadMetaParams p) async {
    try {
      final readMeta = ReadMetaModel(
        targetYear: p.targetYear,
      );

      final result = await _readMetaService.setReadMeta(p.bookId, readMeta);

      if (!result) {
        return const Left(DatabaseFailure('Falha ao definir meta de leitura'));
      }

      // Update the UI with the new data
      await _shelfItemService.getShelfItemById(p.bookId);

      return const Right(true);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}

class SetReadMetaParams {
  final String bookId;
  final int? targetYear;

  SetReadMetaParams({
    required this.bookId,
    required this.targetYear,
  });
}
