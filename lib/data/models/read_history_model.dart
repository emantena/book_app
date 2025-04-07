import 'package:equatable/equatable.dart';

class ReadHistoryModel extends Equatable {
  final String id;
  final DateTime readDate;
  final int page;
  final int percentage;
  final String? note;

  const ReadHistoryModel({
    required this.id,
    required this.readDate,
    required this.page,
    required this.percentage,
    this.note,
  });

  toJson() {
    return {
      'id': id,
      'readDate': readDate.toIso8601String(),
      'page': page,
      'percentage': percentage,
      'note': note,
    };
  }

  static fromJson(json) {
    return ReadHistoryModel(
      id: json['id'],
      readDate: DateTime.parse(json['readDate']),
      page: json['page'],
      percentage: json['percentage'],
      note: json['note'],
    );
  }

  ReadHistoryModel copyWith({
    String? id,
    DateTime? readDate,
    int? page,
    int? percentage,
    String? note,
  }) {
    return ReadHistoryModel(
      id: id ?? this.id,
      readDate: readDate ?? this.readDate,
      page: page ?? this.page,
      percentage: percentage ?? this.percentage,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [id, readDate, page, percentage, note];
}
