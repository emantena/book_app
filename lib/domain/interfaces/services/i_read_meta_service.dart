import '../../../data/models/dto/shelf_item_dto.dart';
import '../../../data/models/read_meta_model.dart';

abstract class IReadMetaService {
  Future<bool> setReadMeta(String bookId, ReadMetaModel readMeta);
  Future<bool> removeReadMeta(String bookId);
  Future<List<ShelfItemDto>> getBooksByYearTarget(int? targetYear);
}
