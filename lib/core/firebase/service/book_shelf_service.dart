import 'package:book_app/core/firebase/service/base_service.dart';
import 'package:book_app/core/firebase/service/interfaces/i_book_shelf_service.dart';

import '../../domain/dto/book_shelf_dto.dart';
import '../../domain/enums/reading_status.dart';
import '../models/shelf_item.dart';
import '../repository/book_shelf_repository.dart';

class BookShelfService extends BaseService implements IBookShelfService {
  final IBookShelfRepository _bookShelfRepository;

  BookShelfService(super.userRepository, this._bookShelfRepository);

  @override
  Future<bool> addBook(ShelfItem shelfItem) async {
    final userId = await getUserId();

    if (!await _bookShelfRepository.existBookShelf(userId: userId)) {
      await _bookShelfRepository.createBookShelf(userId: userId);
      await _bookShelfRepository.addBook(shelfItem, userId);

      return true;
    }

    final bookShelf = await _bookShelfRepository.getBookShelf(userId);

    if (bookShelf.books.any((b) => b.bookId == shelfItem.bookId)) {
      final book =
          bookShelf.books.firstWhere((b) => b.bookId == shelfItem.bookId);

      if (book.readingStatus == shelfItem.readingStatus) {
        return false;
      }

      await _bookShelfRepository.updateBook(shelfItem, userId);
    } else {
      await _bookShelfRepository.addBook(shelfItem, userId);
    }

    return true;
  }

  @override
  Future<BookShelfDto> getBooksByStatus(ReadingStatus? status) async {
    final userId = await getUserId();

    if (status == null) {
      return await _bookShelfRepository.getBookShelf(userId);
    }

    final bookShelf =
        await _bookShelfRepository.getBookShelfByReadingStatus(userId, status);

    return bookShelf;
  }
}
