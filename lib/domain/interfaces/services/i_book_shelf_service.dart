import '../../../data/models/dto/book_shelf_dto.dart';
import '../../../data/models/shelf_item_model.dart';
import '../../entities/reading_status.dart';

abstract class IBookShelfService {
  Future<bool> addBook(ShelfItemModel shelfItem);
  Future<BookShelfDto> getBooksByStatus(ReadingStatus? status);
  // Future<ShelfItemDto> updateReadStatus(
  //     String bookId, ReadingStatus readingStatus);
  // Future<ShelfItemDto> setReadHistory(ReadHistoryDto dto);
  // Future<ShelfItemDto> removeReadHistory(String bookId, String historyId);
}
