part of 'bookshelf_bloc.dart';

class BookshelfState extends Equatable {
  final RequestStatus requestStatus;
  final BookShelfDto bookshelf;
  final String? errorMessage;

  BookshelfState({
    this.requestStatus = RequestStatus.loading,
    BookShelfDto? bookshelf,
    this.errorMessage,
  }) : bookshelf = bookshelf ?? BookShelfDto(pagesRead: 0, books: []);

  BookshelfState copyWith({
    RequestStatus? requestStatus,
    BookShelfDto? bookshelf,
    String? errorMessage,
  }) {
    return BookshelfState(
      requestStatus: requestStatus ?? this.requestStatus,
      bookshelf: bookshelf ?? this.bookshelf,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [requestStatus, bookshelf, errorMessage];
}
