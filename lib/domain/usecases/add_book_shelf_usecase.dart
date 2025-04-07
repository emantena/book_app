import 'package:dartz/dartz.dart';

import 'base_use_case.dart';
import '../entities/book_detail.dart';
import '../interfaces/repositories/i_book_detail_repository.dart';
import '../interfaces/services/i_book_shelf_service.dart';
import '../../core/error/failure.dart';
import '../../data/models/shelf_item_model.dart';

class AddBookShelfUseCase extends BaseUseCase<BookDetail, ShelfItemModel> {
  final IBookShelfService _bookShelfService;
  final IBookDetailRepository _bookDetailRepository;

  AddBookShelfUseCase(this._bookShelfService, this._bookDetailRepository);

  @override
  Future<Either<Failure, BookDetail>> call(ShelfItemModel p) async {
    var result = await _bookShelfService.addBook(p);

    if (!result) {
      return const Left(DatabaseFailure('Ocorreu um erro inesperado'));
    }

    final bookDetail = await _bookDetailRepository.getBookDetails(p.bookId);
    return bookDetail.fold(
      (failure) => Left(failure),
      (bookDetail) async {
        final updatedBookDetail =
            bookDetail.copyWith(readingStatus: p.readingStatus);
        return Right(updatedBookDetail);
      },
    );
  }
}
