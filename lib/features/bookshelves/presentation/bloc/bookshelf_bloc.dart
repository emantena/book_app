import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enum_types.dart';
import '../../../../data/models/dto/book_shelf_dto.dart';
import '../../../../domain/entities/reading_status.dart';
import '../../../../domain/usecases/get_books_by_year_target_usecase.dart';
import '../../../../domain/usecases/show_bookshelf_usecase.dart';

part 'bookshelf_event.dart';
part 'bookshelf_state.dart';

class BookshelfBloc extends Bloc<BookshelfEvent, BookshelfState> {
  final ShowBookShelfUseCase _showBookShelfUseCase;
  final GetBooksByYearTargetUsecase _getBooksByYearTargetUsecase;

  BookshelfBloc(this._showBookShelfUseCase, this._getBooksByYearTargetUsecase)
      : super(BookshelfState.initial()) {
    on<LoadBooksByStatus>(_onLoadBooksByStatus);
    on<ToggleReadingGoalVisibility>(_onToggleReadingGoalVisibility);
  }

  Future<void> _onLoadBooksByStatus(
      LoadBooksByStatus event, Emitter<BookshelfState> emit) async {
    var result = await _showBookShelfUseCase(event.status);

    result.fold(
      (l) => emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          errorMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          requestStatus: RequestStatus.loaded,
          bookshelf: r,
          showReadingGoal: false,
        ),
      ),
    );
  }

  Future<void> _onToggleReadingGoalVisibility(
    ToggleReadingGoalVisibility event,
    Emitter<BookshelfState> emit,
  ) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));

    final targetYear = DateTime.now().year;

    final result = await _getBooksByYearTargetUsecase(targetYear);

    result.fold(
      (failure) => emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (books) {
        final bookShelf = state.bookshelf.copyWith(
          books: books,
        );

        emit(
          state.copyWith(
            requestStatus: RequestStatus.loaded,
            bookshelf: bookShelf,
            showReadingGoal: true,
          ),
        );
      },
    );
  }
}
