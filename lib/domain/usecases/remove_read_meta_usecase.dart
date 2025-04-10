import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../interfaces/services/i_read_meta_service.dart';
import '../interfaces/services/i_shelf_item_service.dart';
import 'base_use_case.dart';

class RemoveReadMetaUsecase extends BaseUseCase<bool, String> {
  final IReadMetaService _readMetaService;
  final IShelfItemService _shelfItemService;

  RemoveReadMetaUsecase(this._readMetaService, this._shelfItemService);

  @override
  Future<Either<Failure, bool>> call(String p) async {
    try {
      final result = await _readMetaService.removeReadMeta(p);

      if (!result) {
        return const Left(DatabaseFailure('Falha ao remover meta de leitura'));
      }

      // Update the UI with the new data
      await _shelfItemService.getShelfItemById(p);

      return const Right(true);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
