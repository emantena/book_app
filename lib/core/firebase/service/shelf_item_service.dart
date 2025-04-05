import 'package:book_app/core/domain/dto/shelf_item_dto.dart';

import '../repository/book_shelf_repository.dart';
import '../repository/interfaces/i_shelf_item_repository.dart';
import 'base_service.dart';
import 'interfaces/i_shelf_item_service.dart';
import '../../domain/enums/reading_status.dart';

class ShelfItemService extends BaseService implements IShelfItemService {
  final IBookShelfRepository _bookShelfRepository;
  final IShelfItemRepository _shelfItemRepository;

  ShelfItemService(
    super.userRepository,
    this._bookShelfRepository,
    this._shelfItemRepository,
  );

  @override
  Future<ShelfItemDto?> getShelfItemById(String bookId) async {
    final userId = await getUserId();

    ShelfItemDto? shelfItem =
        await _shelfItemRepository.getShelfItemById(bookId, userId);

    if (shelfItem == null) {
      return null;
    }

    shelfItem.readHistory
        .sort((a, b) => (b.pages ?? 0).compareTo(a.pages ?? 0));

    return shelfItem;
  }

  @override
  Future<void> updatePageRead(String bookId) async {
    ShelfItemDto? shelfItem = await getShelfItemById(bookId);

    final maxPageRead = shelfItem?.readHistory
            .map((e) => e.pages ?? 0)
            .reduce((a, b) => a > b ? a : b) ??
        0;

    if (shelfItem!.currentPage == maxPageRead) {
      return;
    }

    final totalPagesRead = maxPageRead - shelfItem.currentPage;

    final userId = await getUserId();

    await _shelfItemRepository.updatePagesRead(bookId, userId, maxPageRead);
    await _bookShelfRepository.updatePagesRead(userId, totalPagesRead);
  }

  @override
  Future<ShelfItemDto?> updateReadStatus(
      String bookId, ReadingStatus status) async {
    final bookDto = await getShelfItemById(bookId);

    if (bookDto == null) {
      throw Exception('Livro não encontrado');
    }

    if (status == ReadingStatus.reading) {
      bookDto.startDate = DateTime.now();
    }

    if (bookDto.readingStatus == ReadingStatus.reading &&
        status == ReadingStatus.read) {
      bookDto.endDate = DateTime.now();
    }

    bookDto.readingStatus = status;

    final userId = await getUserId();
    await _shelfItemRepository.updateReadStatus(
        bookId, userId, bookDto.startDate, bookDto.endDate, status);

    return bookDto;
  }
}
