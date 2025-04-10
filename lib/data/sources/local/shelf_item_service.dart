import '../../../domain/entities/reading_status.dart';
import '../../../domain/interfaces/repositories/i_shelf_item_repository.dart';
import '../../../domain/interfaces/services/i_shelf_item_service.dart';
import '../../models/dto/shelf_item_dto.dart';
import '../../repositories/book_shelf_repository.dart';
import 'base_service.dart';

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

    int totalPagesRead = 0;
    int maxPageRead = 0;
    if (shelfItem!.readingStatus == ReadingStatus.read) {
      maxPageRead = shelfItem.pages;
    }

    if (shelfItem.readHistory.isNotEmpty) {
      maxPageRead = shelfItem.readHistory
          .map((e) => e.pages ?? 0)
          .reduce((a, b) => a > b ? a : b);

      if (shelfItem.currentPage == maxPageRead) {
        return;
      }
    }

    totalPagesRead = maxPageRead - shelfItem.currentPage;

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

    if (status == ReadingStatus.read) {
      await updatePageRead(bookId);
    }

    return bookDto;
  }

  @override
  Future<void> addReadData(String bookId, DateTime endDate) async {
    final userId = await getUserId();

    ShelfItemDto? shelfItem = await getShelfItemById(bookId);
    if (shelfItem == null) {
      throw Exception('Livro não encontrado');
    }

    await _shelfItemRepository.updateReadDate(bookId, userId, endDate);
  }

  @override
  Future<void> addRemoveBook(String bookId) async {
    final userId = await getUserId();

    ShelfItemDto? shelfItem = await getShelfItemById(bookId);
    if (shelfItem == null) {
      throw Exception('Livro não encontrado');
    }

    await _bookShelfRepository.updatePagesRead(
        userId, shelfItem.currentPage * (-1));

    await _shelfItemRepository.removeBook(bookId, userId);
  }
}
