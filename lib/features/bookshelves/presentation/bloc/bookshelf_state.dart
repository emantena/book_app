part of 'bookshelf_bloc.dart';

class BookshelfState extends Equatable {
  final BookShelfDto bookshelf;
  final RequestStatus requestStatus;
  final String? errorMessage;
  final bool showReadingGoal;

  const BookshelfState({
    required this.bookshelf,
    required this.requestStatus,
    this.errorMessage,
    this.showReadingGoal = false,
  });

  factory BookshelfState.initial() {
    return BookshelfState(
      bookshelf: BookShelfDto.empty(),
      requestStatus: RequestStatus.initial,
    );
  }

  BookshelfState copyWith({
    BookShelfDto? bookshelf,
    RequestStatus? requestStatus,
    String? errorMessage,
    bool? showReadingGoal,
  }) {
    return BookshelfState(
      bookshelf: bookshelf ?? this.bookshelf,
      requestStatus: requestStatus ?? this.requestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      showReadingGoal: showReadingGoal ?? this.showReadingGoal,
    );
  }

  @override
  List<Object?> get props => [bookshelf, requestStatus, errorMessage, showReadingGoal];
}
