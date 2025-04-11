import '../../../data/models/dto/shelf_item_dto.dart';
import '../../entities/reading_status.dart';

abstract class IShelfItemRepository {
  Future<ShelfItemDto?> getShelfItemById(String bookId, String userId);
  Future<void> updatePagesRead(String bookId, String userId, int pagesRead);
  Future<void> updateReadDate(String bookId, String userId, DateTime endDate);
  Future<void> removeBook(String bookId, String userId);
  Future<void> updateReadStatus(
    String bookId,
    String userId,
    DateTime? startDate,
    DateTime? endDate,
    ReadingStatus status,
  );
}
