import 'package:collection/collection.dart';

import '../../../domain/entities/reading_status.dart';
import 'base_service.dart';
import '../../models/dto/read_history_dto.dart';
import '../../models/dto/shelf_item_dto.dart';
import '../../../domain/interfaces/repositories/i_read_history_repository.dart';
import '../../../domain/interfaces/services/i_read_history_service.dart';
import '../../../domain/interfaces/services/i_shelf_item_service.dart';

class ReadHistoryService extends BaseService implements IReadHistoryService {
  final IShelfItemService _shelfItemService;
  final IReadHistoryRepository _readHistoryRepository;

  ReadHistoryService(
    super.userRepository,
    this._shelfItemService,
    this._readHistoryRepository,
  );

  @override
  Future<ShelfItemDto> setReadHistory(ReadHistoryDto readHistory) async {
    ShelfItemDto? shelfItemDto = await _shelfItemService.getShelfItemById(readHistory.bookId);
    final bookPages = shelfItemDto!.pages;

    if (readHistory.pages != null && readHistory.pages! > bookPages) {
      throw Exception('O número de páginas não pode ser maior que $bookPages.');
    }

    if (readHistory.percentage != null && readHistory.percentage! > 100) {
      throw Exception('A porcentagem não pode ser maior que 100%.');
    }

    final userId = await getUserId();

    if (shelfItemDto.readingStatus != ReadingStatus.reading) {
      shelfItemDto.readingStatus = ReadingStatus.reading;
      _shelfItemService.updateReadStatus(shelfItemDto.bookId, ReadingStatus.reading);
    }

    if (readHistory.percentage == null) {
      readHistory = readHistory.copyWith(
        percentage: (readHistory.pages! * 100 / bookPages).round(),
      );
    }

    if (readHistory.pages == null) {
      readHistory = readHistory.copyWith(
        pages: (readHistory.percentage! * bookPages / 100).round(),
      );
    }

    final currentHistoryDto = shelfItemDto.readHistory.firstWhereOrNull((h) => h.id == readHistory.id);

    if (currentHistoryDto != null) {
      await _readHistoryRepository.updateReadHistory(
          currentHistoryDto.id!, shelfItemDto.bookId, userId, readHistory.pages!, readHistory.percentage!);
    } else {
      await _readHistoryRepository.addReadHistory(
        readHistory.toModel(),
        shelfItemDto.bookId,
        userId,
      );
    }

    await _shelfItemService.updatePageRead(shelfItemDto.bookId);

    if (readHistory.percentage == 100) {
      shelfItemDto = await _shelfItemService.updateReadStatus(shelfItemDto.bookId, ReadingStatus.read);
    }

    shelfItemDto = await _shelfItemService.getShelfItemById(readHistory.bookId);

    return shelfItemDto!;
  }

  @override
  Future<ShelfItemDto> removeReadHistory(String bookId, String historyId) async {
    final userId = await getUserId();

    await _readHistoryRepository.removeReadHistory(historyId, bookId, userId);

    await _shelfItemService.updatePageRead(bookId);

    final shelfItem = await _shelfItemService.getShelfItemById(bookId);

    return shelfItem!;
  }

  @override
  Future<List<ReadHistoryDto>> getReadHistory(String bookId) {
    throw UnimplementedError();
  }
}
