import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/dto/add_read_data_dto.dart';
import '../interfaces/services/i_shelf_item_service.dart';
import 'base_use_case.dart';

class AddReadDataUsecase extends BaseUseCase<bool, AddReadDataDto> {
  final IShelfItemService _shelfItemService;

  AddReadDataUsecase(this._shelfItemService);

  @override
  Future<Either<Failure, bool>> call(AddReadDataDto p) async {
    try {
      await _shelfItemService.addReadData(p.bookId, p.readDate);
      return const Right(true);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
