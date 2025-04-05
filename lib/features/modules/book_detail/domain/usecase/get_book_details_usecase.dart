import 'package:book_app/core/firebase/service/interfaces/i_shelf_item_service.dart';
import 'package:dartz/dartz.dart';

import '../repository/book_detail_repository.dart';
import '../../../../../core/data/error/failure.dart';
import '../../../../../core/domain/entities/book_detail.dart';
import '../../../../../core/domain/usecase/base_use_case.dart';

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

        final updatedBookDetail =
            bookDetail.copyWith(readingStatus: book?.readingStatus);
        return Right(updatedBookDetail);
      },
    );
  }
}
