import '../../../domain/dto/shelf_item_dto.dart';
import '../../../domain/enums/reading_status.dart';

abstract class IShelfItemService {
  Future<ShelfItemDto?> getShelfItemById(String bookId);
  
  Future<void> updatePageRead(String bookId);
  Future<ShelfItemDto?> updateReadStatus(String bookId, ReadingStatus status);
}
