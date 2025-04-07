import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enum_types.dart';
import '../../../../data/models/dto/book_shelf_dto.dart';
import '../../../../domain/entities/reading_status.dart';
import '../../../../domain/usecases/show_bookshelf_usecase.dart';

part 'bookshelf_event.dart';
part 'bookshelf_state.dart';

class BookshelfBloc extends Bloc<BookshelfEvent, BookshelfState> {
  final ShowBookShelfUseCase _showBookShelfUseCase;

  BookshelfBloc(this._showBookShelfUseCase) : super(BookshelfState()) {
    on<LoadBooksByStatus>(_onLoadBooksByStatus);
  }

  Future<void> _onLoadBooksByStatus(LoadBooksByStatus event, Emitter<BookshelfState> emit) async {
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
        ),
      ),
    );
  }
}
