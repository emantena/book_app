import '../../../domain/entities/reading_status.dart';
import '../read_history_model.dart';
import '../read_meta_model.dart';
import '../shelf_item_model.dart';
import 'read_history_dto.dart';

class ShelfItemDto {
  final String bookId;
  final String imageUrl;
  final int pages;

  String title;
  ReadingStatus readingStatus;
  DateTime? startDate;
  DateTime? endDate;
  int currentPage;
  List<ReadHistoryDto> readHistory = [];
  ReadMetaModel? readMeta;

  ShelfItemDto({
    this.title = '',
    this.bookId = '',
    this.readingStatus = ReadingStatus.wantToRead,
    this.startDate,
    this.endDate,
    this.imageUrl = '',
    this.pages = 0,
    this.currentPage = 0,
    this.readHistory = const [],
    this.readMeta,
  });

  static fromModel(ShelfItemModel p) {
    return ShelfItemDto(
      title: p.title,
      bookId: p.bookId,
      imageUrl: p.imageUrl,
      pages: p.pages,
      readingStatus: p.readingStatus,
      startDate: p.startDate,
      endDate: p.endDate,
      currentPage: p.currentPage,
      readHistory: [],
      readMeta: p.readMeta,
    );
  }

  static ShelfItemModel toModel(ShelfItemDto p) {
    return ShelfItemModel(
      bookId: p.bookId,
      title: p.title,
      readingStatus: p.readingStatus,
      startDate: p.startDate,
      endDate: p.endDate,
      imageUrl: p.imageUrl,
      pages: p.pages,
      currentPage: p.currentPage,
      readHistory: p.readHistory
          .map(
            (e) => ReadHistoryModel(
              id: e.id!,
              readDate: e.dateRead,
              page: e.pages!,
              percentage: e.percentage!,
              note: e.note,
            ),
          )
          .toList(),
      readMeta: p.readMeta,
    );
  }
}
