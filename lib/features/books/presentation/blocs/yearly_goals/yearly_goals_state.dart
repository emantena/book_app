part of 'yearly_goals_bloc.dart';

class YearlyGoalsState extends Equatable {
  final RequestStatus status;
  final List<ShelfItemDto> books;
  final int? currentYear;
  final String? errorMessage;

  const YearlyGoalsState({
    this.status = RequestStatus.initial,
    this.books = const [],
    this.currentYear,
    this.errorMessage,
  });

  YearlyGoalsState copyWith({
    RequestStatus? status,
    List<ShelfItemDto>? books,
    int? currentYear,
    String? errorMessage,
  }) {
    return YearlyGoalsState(
      status: status ?? this.status,
      books: books ?? this.books,
      currentYear: currentYear ?? this.currentYear,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, books, currentYear, errorMessage];
}
