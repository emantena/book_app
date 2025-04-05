import 'package:equatable/equatable.dart';

import '../../firebase/models/read_history.dart';

class ReadHistoryDto extends Equatable {
  final String bookId;
  final String? id;
  final DateTime dateRead;
  final int? pages;
  final int? percentage;
  final String? note;

  const ReadHistoryDto(
    this.bookId,
    this.id,
    this.dateRead,
    this.pages,
    this.percentage,
    this.note,
  );

  ReadHistoryDto copyWith({
    String? bookId,
    String? id,
    DateTime? dateRead,
    int? pages,
    int? percentage,
    String? note,
  }) {
    return ReadHistoryDto(
      bookId ?? this.bookId,
      id ?? this.id,
      dateRead ?? this.dateRead,
      pages ?? this.pages,
      percentage ?? this.percentage,
      note ?? this.note,
    );
  }

  ReadHistory toModel() {
    return ReadHistory(
      id: id!,
      readDate: dateRead,
      page: pages ?? 0,
      percentage: percentage ?? 0,
      note: note,
    );
  }

  @override
  List<Object?> get props => [bookId, id, dateRead, pages, percentage, note];
}
