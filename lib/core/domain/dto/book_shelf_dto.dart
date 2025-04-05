import 'package:book_app/core/domain/dto/shelf_item_dto.dart';

class BookShelfDto {
  int pagesRead;
  final List<ShelfItemDto> books;

  BookShelfDto({
    required this.pagesRead,
    required this.books,
  });

  void setPagesRead(int pagesRead) {
    this.pagesRead += pagesRead;
  }
}
