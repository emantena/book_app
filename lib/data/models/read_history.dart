import 'package:equatable/equatable.dart';

class ReadHistory extends Equatable {
  final String id;
  final DateTime readDate;
  final int page;
  final int percentage;
  final String? note;

  const ReadHistory({
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
    return ReadHistory(
      id: json['id'],
      readDate: DateTime.parse(json['readDate']),
      page: json['page'],
      percentage: json['percentage'],
      note: json['note'],
    );
  }

  ReadHistory copyWith({
    String? id,
    DateTime? readDate,
    int? page,
    int? percentage,
    String? note,
  }) {
    return ReadHistory(
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
