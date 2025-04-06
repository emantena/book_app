import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/enum_types.dart';
import '../../../data/models/shelf_item.dart';
import '../../../domain/entities/book_detail.dart';
import '../../../domain/usecases/add_book_shelf_usecase.dart';
import '../../../domain/usecases/get_book_details_usecase.dart';

part 'book_detail_event.dart';
part 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final GetBookDetailsUsecase _getBookDetailUseCase;
  final AddBookShelfUseCase _addBookToShelfUseCase;

  BookDetailBloc(this._getBookDetailUseCase, this._addBookToShelfUseCase) : super(const BookDetailState()) {
    on<GetBookDetailEvent>(_getBookDetail);
    on<AddBookToShelfEvent>(_addBookToShelf);
  }

  Future<void> _getBookDetail(GetBookDetailEvent event, Emitter<BookDetailState> emit) async {
    final result = await _getBookDetailUseCase(event.bookId);
    result.fold(
      (l) => emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          requestStatus: RequestStatus.loaded,
          bookDetail: r,
        ),
      ),
    );
  }

  Future<void> _addBookToShelf(AddBookToShelfEvent event, Emitter<BookDetailState> emit) async {
    final result = await _addBookToShelfUseCase(event.shelfItem);

    result.fold(
      (l) => emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          requestStatus: RequestStatus.loaded,
          bookDetail: r,
        ),
      ),
    );
  }
}
