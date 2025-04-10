import 'package:book_app/domain/interfaces/services/i_shelf_item_service.dart';

import '../../../domain/entities/reading_status.dart';
import '../../../domain/interfaces/services/i_book_shelf_service.dart';
import '../../models/dto/book_shelf_dto.dart';
import '../../models/shelf_item_model.dart';
import '../../repositories/book_shelf_repository.dart';
import 'base_service.dart';

class BookShelfService extends BaseService implements IBookShelfService {
  final IBookShelfRepository _bookShelfRepository;
  final IShelfItemService _shelfItemService;

  BookShelfService(
      super.userRepository, this._bookShelfRepository, this._shelfItemService);

  @override
  Future<bool> addBook(ShelfItemModel shelfItem) async {
    final userId = await getUserId();

    if (!await _bookShelfRepository.existBookShelf(userId: userId)) {
      await _bookShelfRepository.createBookShelf(userId: userId);
      await _bookShelfRepository.addBook(shelfItem, userId);

      return true;
    }

    final bookShelf = await _bookShelfRepository.getBookShelf(userId);

    if (bookShelf.books.any((b) => b.bookId == shelfItem.bookId)) {
      return false;
    } else {
      await _bookShelfRepository.addBook(shelfItem, userId);
    }

    if (shelfItem.readingStatus == ReadingStatus.read) {
      await _shelfItemService.updatePageRead(shelfItem.bookId);
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
