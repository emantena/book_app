import 'package:dartz/dartz.dart';

import 'base_use_case.dart';
import '../interfaces/services/i_shelf_item_service.dart';
import '../entities/book_detail.dart';
import '../interfaces/repositories/i_book_detail_repository.dart';
import '../../core/error/failure.dart';

class GetBookDetailsUsecase extends BaseUseCase<BookDetail, String> {
  final IBookDetailRepository _bookDetailRepository;
  final IShelfItemService _shelfItemService;

  GetBookDetailsUsecase(this._bookDetailRepository, this._shelfItemService);

  @override
  Future<Either<Failure, BookDetail>> call(String p) async {
    final result = await _bookDetailRepository.getBookDetails(p);

    return result.fold(
      (failure) => Left(failure),
      (bookDetail) async {
        final book = await _shelfItemService.getShelfItemById(p);

        final updatedBookDetail = bookDetail.copyWith(readingStatus: book?.readingStatus);
        return Right(updatedBookDetail);
      },
    );
  }
}
