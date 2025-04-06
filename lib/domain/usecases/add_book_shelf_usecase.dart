import 'package:dartz/dartz.dart';

import 'base_use_case.dart';
import '../entities/book_detail.dart';
import '../interfaces/repositories/i_book_detail_repository.dart';
import '../interfaces/repositories/i_book_shelf_service.dart';
import '../../core/data/error/failure.dart';
import '../../data/models/shelf_item.dart';

class AddBookShelfUseCase extends BaseUseCase<BookDetail, ShelfItem> {
  final IBookShelfService _bookShelfService;
  final IBookDetailRepository _bookDetailRepository;

  AddBookShelfUseCase(this._bookShelfService, this._bookDetailRepository);

  @override
  Future<Either<Failure, BookDetail>> call(ShelfItem p) async {
    var result = await _bookShelfService.addBook(p);

    if (!result) {
      return const Left(DatabaseFailure('Ocorreu um erro inesperado'));
    }

    final bookDetail = await _bookDetailRepository.getBookDetails(p.bookId);
    return bookDetail.fold(
      (failure) => Left(failure),
      (bookDetail) async {
        final updatedBookDetail = bookDetail.copyWith(readingStatus: p.readingStatus);
        return Right(updatedBookDetail);
      },
    );
  }
}
