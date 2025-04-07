part of 'book_options_bloc.dart';

class BookOptionsState extends Equatable {
  final RequestStatus requestStatus;
  final ShelfItemDto? bookItem;
  final String? errorMessage;

  const BookOptionsState({
    this.requestStatus = RequestStatus.initial,
    this.bookItem,
    this.errorMessage,
  });

  BookOptionsState copyWith({
    RequestStatus? requestStatus,
    String? errorMessage,
    ShelfItemDto? bookItem,
  }) {
    return BookOptionsState(
      requestStatus: requestStatus ?? this.requestStatus,
      bookItem: bookItem ?? this.bookItem,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [requestStatus, errorMessage, bookItem];
}
