import 'package:book_app/core/firebase/models/shelf_item.dart';

import '../../firebase/models/read_history.dart';
import '../enums/reading_status.dart';
import 'read_history_dto.dart';

class ShelfItemDto {
  final String bookId;
  final String imageUrl;
  final int pages;
  final String title;
  ReadingStatus readingStatus;
  DateTime? startDate;
  DateTime? endDate;
  int currentPage;
  List<ReadHistoryDto> readHistory = [];

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
  });

  static fromModel(ShelfItem p) {
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
    );
  }

  static ShelfItem toModel(ShelfItemDto p) {
    return ShelfItem(
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
            (e) => ReadHistory(
              id: e.id!,
              readDate: e.dateRead,
              page: e.pages!,
              percentage: e.percentage!,
              note: e.note,
            ),
          )
          .toList(),
    );
  }
}
