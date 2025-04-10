import '../../../data/models/dto/shelf_item_dto.dart';
import '../../../data/models/read_meta_model.dart';

abstract class IReadMetaRepository {
  Future<void> setReadMeta(String bookId, String userId, ReadMetaModel readMeta);
  Future<void> removeReadMeta(String bookId, String userId);
  Future<List<ShelfItemDto>> getBooksByYearTarget(int? targetYear, String userId);
}
