part of 'book_detail_bloc.dart';

abstract class BookDetailEvent extends Equatable {
  const BookDetailEvent();
}

class GetBookDetailEvent extends BookDetailEvent {
  final String bookId;
  const GetBookDetailEvent(this.bookId);

  @override
  List<Object> get props => [bookId];
}

class AddBookToShelfEvent extends BookDetailEvent {
  final ShelfItemModel shelfItem;
  const AddBookToShelfEvent(this.shelfItem);

  @override
  List<Object?> get props => [shelfItem];
}
