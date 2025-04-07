part of 'book_detail_bloc.dart';

class BookDetailState extends Equatable {
  final BookDetail? bookDetail;
  final RequestStatus requestStatus;
  final String? message;

  const BookDetailState({
    this.bookDetail,
    this.requestStatus = RequestStatus.loading,
    this.message,
  });

  BookDetailState copyWith({
    BookDetail? bookDetail,
    RequestStatus? requestStatus,
    String? message,
  }) {
    return BookDetailState(
      bookDetail: bookDetail ?? this.bookDetail,
      requestStatus: requestStatus ?? this.requestStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        bookDetail,
        requestStatus,
        message,
      ];
}
