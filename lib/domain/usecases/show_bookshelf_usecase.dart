import 'package:dartz/dartz.dart';

import '../../core/data/error/failure.dart';
import '../../data/models/dto/book_shelf_dto.dart';
import '../entities/reading_status.dart';
import '../interfaces/repositories/i_book_shelf_service.dart';
import 'base_use_case.dart';

class ShowBookShelfUseCase extends BaseUseCase<BookShelfDto, ReadingStatus?> {
  final IBookShelfService _bookShelfService;

  ShowBookShelfUseCase(this._bookShelfService);

  @override
  Future<Either<Failure, BookShelfDto>> call(ReadingStatus? p) async {
    try {
      final result = await _bookShelfService.getBooksByStatus(p);

      return Right(result);
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
