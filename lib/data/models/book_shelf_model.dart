import 'package:equatable/equatable.dart';

class BookShelfModel extends Equatable {
  final int pagesRead;

  const BookShelfModel({required this.pagesRead});

  factory BookShelfModel.fromJson(Map<String, dynamic> json) {
    return BookShelfModel(
      pagesRead: json['pagesRead'] ?? 0,
    );
  }

  BookShelfModel copyWith({
    int? pagesRead,
  }) {
    return BookShelfModel(
      pagesRead: pagesRead ?? this.pagesRead,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pagesRead': pagesRead,
    };
  }

  @override
  List<Object?> get props => [pagesRead];
}
