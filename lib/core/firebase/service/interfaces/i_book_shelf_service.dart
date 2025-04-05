import 'package:book_app/core/domain/dto/book_shelf_dto.dart';
import 'package:book_app/core/domain/enums/reading_status.dart';
import 'package:book_app/core/firebase/models/shelf_item.dart';

abstract class IBookShelfService {
  Future<bool> addBook(ShelfItem shelfItem);
  Future<BookShelfDto> getBooksByStatus(ReadingStatus? status);
  // Future<ShelfItemDto> updateReadStatus(
  //     String bookId, ReadingStatus readingStatus);
  // Future<ShelfItemDto> setReadHistory(ReadHistoryDto dto);
  // Future<ShelfItemDto> removeReadHistory(String bookId, String historyId);
}
