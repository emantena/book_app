import '../../../domain/dto/read_history_dto.dart';
import '../../../domain/dto/shelf_item_dto.dart';

abstract class IReadHistoryService {
  Future<ShelfItemDto> setReadHistory(ReadHistoryDto dto);
  Future<ShelfItemDto> removeReadHistory(String bookId, String historyId);
  Future<List<ReadHistoryDto>> getReadHistory(String bookId);
}
