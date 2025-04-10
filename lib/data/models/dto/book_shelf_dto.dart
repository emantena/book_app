import 'package:equatable/equatable.dart';

import 'shelf_item_dto.dart';

class BookShelfDto extends Equatable {
  final int pagesRead;
  final List<ShelfItemDto> books;

  const BookShelfDto({
    required this.pagesRead,
    required this.books,
  });

  factory BookShelfDto.empty() {
    return const BookShelfDto(
      pagesRead: 0,
      books: [],
    );
  }

  BookShelfDto copyWith({
    int? pagesRead,
    List<ShelfItemDto>? books,
  }) {
    return BookShelfDto(
      pagesRead: pagesRead ?? this.pagesRead,
      books: books ?? this.books,
    );
  }

  BookShelfDto setPagesRead(int pagesRead) {
    return copyWith(pagesRead: this.pagesRead + pagesRead);
  }

  @override
  List<Object?> get props => [
        pagesRead,
        books,
      ];
}
