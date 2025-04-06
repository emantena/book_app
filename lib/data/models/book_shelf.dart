import 'package:equatable/equatable.dart';

class BookShelf extends Equatable{
  final int pagesRead;

  const BookShelf({required this.pagesRead});

  factory BookShelf.fromJson(Map<String, dynamic> json) {
    return BookShelf(
      pagesRead: json['pagesRead'] ?? 0,
    );
  }

  BookShelf copyWith({
    int? pagesRead,
  }) {
    return BookShelf(
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
