import '../../../data/models/dto/shelf_item_dto.dart';
import '../../entities/reading_status.dart';

abstract class IShelfItemService {
  Future<ShelfItemDto?> getShelfItemById(String bookId);

  Future<void> updatePageRead(String bookId);
  Future<ShelfItemDto?> updateReadStatus(String bookId, ReadingStatus status);
}
