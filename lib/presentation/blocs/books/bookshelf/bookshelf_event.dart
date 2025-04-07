part of 'bookshelf_bloc.dart';

abstract class BookshelfEvent extends Equatable {
  const BookshelfEvent();

  @override
  List<Object?> get props => [];
}

class LoadBooksByStatus extends BookshelfEvent {
  final ReadingStatus? status;

  const LoadBooksByStatus(this.status);

  @override
  List<Object?> get props => [status];
}
