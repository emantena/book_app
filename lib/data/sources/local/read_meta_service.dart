import 'package:book_app/domain/interfaces/repositories/i_read_meta_repository.dart';

import '../../../domain/interfaces/services/i_read_meta_service.dart';
import '../../../domain/interfaces/services/i_shelf_item_service.dart';
import '../../models/dto/shelf_item_dto.dart';
import '../../models/read_meta_model.dart';
import 'base_service.dart';

class ReadMetaService extends BaseService implements IReadMetaService {
  final IShelfItemService _shelfItemService;
  final IReadMetaRepository _readMetaRepository;

  ReadMetaService(
    super.userRepository,
    this._shelfItemService,
    this._readMetaRepository,
  );

  @override
  Future<bool> setReadMeta(String bookId, ReadMetaModel readMeta) async {
    try {
      var shelfItem = await _shelfItemService.getShelfItemById(bookId);

      if (shelfItem == null) {
        throw Exception('Livro não encontrado');
      }

      shelfItem.readMeta = readMeta;

      final userId = await getUserId();

      await _readMetaRepository.setReadMeta(bookId, userId, readMeta);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> removeReadMeta(String bookId) async {
    try {
      var shelfItem = await _shelfItemService.getShelfItemById(bookId);

      if (shelfItem == null) {
        throw Exception('Livro não encontrado');
      }

      await _readMetaRepository.removeReadMeta(bookId, await getUserId());

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<ShelfItemDto>> getBooksByYearTarget(int? targetYear) async {
    try {
      final userId = await getUserId();

      return _readMetaRepository.getBooksByYearTarget(targetYear, userId);
    } catch (e) {
      return [];
    }
  }
}
