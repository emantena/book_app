import 'package:book_app/data/models/read_meta_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/reading_status.dart';
import 'dto/shelf_item_dto.dart';
import 'read_history_model.dart';

class ShelfItemModel {
  final String bookId;
  final String imageUrl;
  final int pages;

  String title;
  ReadingStatus readingStatus;
  DateTime? startDate;
  DateTime? endDate;
  int currentPage;
  List<ReadHistoryModel>? readHistory;
  ReadMetaModel? readMeta;

  ShelfItemModel({
    this.bookId = '',
    this.title = '',
    this.readingStatus = ReadingStatus.wantToRead,
    this.startDate,
    this.endDate,
    this.imageUrl = '',
    this.pages = 0,
    this.currentPage = 0,
    this.readHistory,
    this.readMeta,
  });

  factory ShelfItemModel.fromJson(Map<String, dynamic> json) {
    return ShelfItemModel(
      bookId: json['bookId'] ?? '',
      title: json['title'] ?? '',
      readingStatus: ReadingStatus.values[json['readingStatus'] ?? 0],
      startDate: json['startDate'] != null
          ? (json['startDate'] as Timestamp).toDate()
          : null,
      endDate: json['endDate'] != null
          ? (json['endDate'] as Timestamp).toDate()
          : null,
      imageUrl: json['imageUrl'] ?? '',
      pages: json['pages'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      readHistory: json['readHistory'] != null
          ? List<ReadHistoryModel>.from(json['readHistory'].map(
              (x) => ReadHistoryModel.fromJson(x),
            ))
          : [],
      readMeta: json['readMeta'] != null
          ? ReadMetaModel.fromJson(json['readMeta'])
          : null,
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
      'readMeta': readMeta?.toJson(),
    };
  }

  static fromDto(ShelfItemDto p) {
    return ShelfItemModel(
      bookId: p.bookId,
      title: p.title,
      readingStatus: p.readingStatus,
      startDate: p.startDate,
      endDate: p.endDate,
      imageUrl: p.imageUrl,
      pages: p.pages,
      currentPage: p.currentPage,
      readHistory: [],
      readMeta: p.readMeta,
    );
  }
}
