part of 'book_options_bloc.dart';

abstract class BookOptionsEvent extends Equatable {
  const BookOptionsEvent();

  @override
  List<Object?> get props => [];
}

class LoadBookEvent extends BookOptionsEvent {
  final String bookId;

  const LoadBookEvent(this.bookId);

  @override
  List<Object?> get props => [bookId];
}

class ChangeReadingStatusEvent extends BookOptionsEvent {
  final ReadingStatus readingStatus;
  final String bookId;

  const ChangeReadingStatusEvent(this.readingStatus, this.bookId);

  @override
  List<Object?> get props => [readingStatus, bookId];
}

class SetReadHistoryEvent extends BookOptionsEvent {
  final String bookId;
  final int? pagesRead;
  final int? percentRead;
  final String? id;

  const SetReadHistoryEvent(this.bookId, this.pagesRead, this.percentRead, this.id);

  @override
  List<Object?> get props => [pagesRead, percentRead, bookId];
}

class DeleteReadHistoryEvent extends BookOptionsEvent {
  final String bookId;
  final String historyId;

  const DeleteReadHistoryEvent(this.bookId, this.historyId);

  @override
  List<Object?> get props => [bookId, historyId];
}

class AddReadDateEvent extends BookOptionsEvent {
  final DateTime startDate;
  final DateTime endDate;
  final String bookId;

  const AddReadDateEvent(this.startDate, this.endDate, this.bookId);

  @override
  List<Object?> get props => [startDate, endDate, bookId];
}

// class SetReadMetaEvent extends BookOptionsEvent {
//   final String bookId;
//   final int yearToRead;

//   const SetReadMetaEvent(this.yearToRead, this.bookId);

//   @override
//   List<Object?> get props => [yearToRead, bookId];
// }

class RemoveBookEvent extends BookOptionsEvent {
  final String bookId;

  const RemoveBookEvent(this.bookId);

  @override
  List<Object?> get props => [bookId];
}

class SetReadMetaEvent extends BookOptionsEvent {
  final String bookId;
  final int? targetYear;

  const SetReadMetaEvent({
    required this.bookId,
    required this.targetYear,
  });

  @override
  List<Object?> get props => [bookId, targetYear];
}

class RemoveReadMetaEvent extends BookOptionsEvent {
  final String bookId;

  const RemoveReadMetaEvent(this.bookId);

  @override
  List<Object?> get props => [bookId];
}
