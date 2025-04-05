import 'package:book_app/core/domain/enums/reading_status.dart';

import '../../domain/dto/shelf_item_dto.dart';
import 'read_history.dart';

class ShelfItem {
  final String bookId;
  final String imageUrl;
  final int pages;

  String title;
  ReadingStatus readingStatus;
  DateTime? startDate;
  DateTime? endDate;
  int currentPage;
  List<ReadHistory>? readHistory;

  ShelfItem({
    this.bookId = '',
    this.title = '',
    this.readingStatus = ReadingStatus.wantToRead,
    this.startDate,
    this.endDate,
    this.imageUrl = '',
    this.pages = 0,
    this.currentPage = 0,
    this.readHistory,
  });

  factory ShelfItem.fromJson(Map<String, dynamic> json) {
    return ShelfItem(
      bookId: json['bookId'] ?? '',
      title: json['title'] ?? '',
      readingStatus: ReadingStatus.values[json['readingStatus'] ?? 0],
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      imageUrl: json['imageUrl'] ?? '',
      pages: json['pages'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      readHistory: json['readHistory'] != null
          ? List<ReadHistory>.from(
              json['readHistory'].map((x) => ReadHistory.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'title': title,
      'readingStatus': readingStatus.index,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'pages': pages,
      'currentPage': currentPage,
      'imageUrl': imageUrl,
    };
  }

  static fromDto(ShelfItemDto p) {
    return ShelfItem(
      bookId: p.bookId,
      title: p.title,
      readingStatus: p.readingStatus,
      startDate: p.startDate,
      endDate: p.endDate,
      imageUrl: p.imageUrl,
      pages: p.pages,
      currentPage: p.currentPage,
      readHistory: [],
    );
  }
}
