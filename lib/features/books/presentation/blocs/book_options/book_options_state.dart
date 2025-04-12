part of 'book_options_bloc.dart';

class BookOptionsState extends Equatable {
  final RequestStatus requestStatus;
  final ShelfItemDto? bookItem;
  final String? errorMessage;
  final OperationType operationType;

  const BookOptionsState({
    this.requestStatus = RequestStatus.initial,
    this.bookItem,
    this.errorMessage,
    this.operationType = OperationType.initial,
  });

  BookOptionsState copyWith({
    RequestStatus? requestStatus,
    String? errorMessage,
    ShelfItemDto? bookItem,
    OperationType? operationType,
  }) {
    return BookOptionsState(
      requestStatus: requestStatus ?? this.requestStatus,
      bookItem: bookItem ?? this.bookItem,
      errorMessage: errorMessage ?? this.errorMessage,
      operationType: operationType ?? this.operationType,
    );
  }

  @override
  List<Object?> get props => [requestStatus, errorMessage, bookItem];
}

enum OperationType {
  initial,
  loadBook,
  changeStatus,
  addHistory,
  removeHistory,
  removeBook,
  setReadMeta,
  removeReadMeta, addReadDate,
}
