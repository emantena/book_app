import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/enum_types.dart';
import '../../../../../core/utils/functions.dart';
import '../../../../../data/models/dto/add_read_data_dto.dart';
import '../../../../../data/models/request/change_read_status_request.dart';
import '../../../../../data/models/dto/read_history_dto.dart';
import '../../../../../data/models/request/remove_read_history_request.dart';
import '../../../../../data/models/dto/shelf_item_dto.dart';
import '../../../../../domain/entities/reading_status.dart';
import '../../../../../domain/usecases/add_read_data_usecase.dart';
import '../../../../../domain/usecases/change_read_status_usecase.dart';
import '../../../../../domain/usecases/delete_read_history_usecase.dart';
import '../../../../../domain/usecases/load_book_usecase.dart';
import '../../../../../domain/usecases/remove_book_usecase.dart';
import '../../../../../domain/usecases/remove_read_meta_usecase.dart';
import '../../../../../domain/usecases/set_read_history_usecase.dart';
import '../../../../../domain/usecases/set_read_meta_usecase.dart';

part 'book_options_state.dart';
part 'book_options_event.dart';

class BookOptionsBloc extends Bloc<BookOptionsEvent, BookOptionsState> {
  final LoadBookUsecase _loadBookUsecase;
  final ChangeReadStatusUsecase _changeReadingStatusUsecase;
  final SetReadHistoryUsecase _readHistoryUsecase;
  final DeleteReadHistoryUsecase _deleteReadHistoryUsecase;
  final SetReadMetaUsecase _setReadMetaUsecase;
  final RemoveReadMetaUsecase _removeReadMetaUsecase;
  final AddReadDataUsecase _addReadDateUsecase;
  final RemoveBookUsecase _removeBookUsecase;

  BookOptionsBloc(
    this._loadBookUsecase,
    this._changeReadingStatusUsecase,
    this._readHistoryUsecase,
    this._deleteReadHistoryUsecase,
    this._setReadMetaUsecase,
    this._removeReadMetaUsecase,
    this._addReadDateUsecase,
    this._removeBookUsecase,
  ) : super(const BookOptionsState()) {
    on<LoadBookEvent>(_onLoadBookEvent);
    on<ChangeReadingStatusEvent>(_onChangeReadingStatusEvent);
    on<DeleteReadHistoryEvent>(_onDeleteReadHistoryEvent);
    on<AddReadDateEvent>(_onAddReadDateEvent);
    on<SetReadHistoryEvent>(_onSetReadHistoryEvent);
    on<RemoveBookEvent>(_onRemoveBookEvent);
    on<RemoveReadMetaEvent>(_onRemoveReadMetaEvent);
    on<SetReadMetaEvent>(_onSetReadMetaEvent);
  }

  Future<void> _onLoadBookEvent(
      LoadBookEvent event, Emitter<BookOptionsState> emit) async {
    emit(
      state.copyWith(requestStatus: RequestStatus.loading),
    );

    final result = await _loadBookUsecase(event.bookId);

    result.fold(
        (l) => emit(
              state.copyWith(
                errorMessage: l.message,
                requestStatus: RequestStatus.error,
              ),
            ), (r) {
      emit(
        state.copyWith(
          requestStatus: RequestStatus.loaded,
          bookItem: r,
        ),
      );
    });
  }

  Future<void> _onChangeReadingStatusEvent(
      ChangeReadingStatusEvent event, Emitter<BookOptionsState> emit) async {
    var result = await _changeReadingStatusUsecase(
      ChangeReadStatusRequest(
        bookId: event.bookId,
        readingStatus: event.readingStatus,
      ),
    );

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          requestStatus: RequestStatus.error,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            requestStatus: RequestStatus.loaded,
            bookItem: r,
          ),
        );
      },
    );
  }

  Future<void> _onSetReadHistoryEvent(
      SetReadHistoryEvent event, Emitter<BookOptionsState> emit) async {
    String? id = event.id;

    if (event.id == null) {
      id = generateUniqueId();
    }

    final dto = ReadHistoryDto(event.bookId, id, DateTime.now(),
        event.pagesRead, event.percentRead, null);

    final result = await _readHistoryUsecase(dto);

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          requestStatus: RequestStatus.error,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            requestStatus: RequestStatus.loaded,
            bookItem: r,
          ),
        );
      },
    );
  }

  Future<void> _onDeleteReadHistoryEvent(
      DeleteReadHistoryEvent event, Emitter<BookOptionsState> emit) async {
    final result = await _deleteReadHistoryUsecase(
        RemoveReadHistoryRequest(event.bookId, event.historyId));

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          requestStatus: RequestStatus.error,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            requestStatus: RequestStatus.loaded,
            bookItem: r,
          ),
        );
      },
    );
  }

  Future<void> _onSetReadMetaEvent(
      SetReadMetaEvent event, Emitter<BookOptionsState> emit) async {
    final params = SetReadMetaParams(
      bookId: event.bookId,
      targetYear: event.targetYear,
    );

    final result = await _setReadMetaUsecase(params);

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          requestStatus: RequestStatus.error,
        ),
      ),
      (r) {
        // Reload the book to get updated data
        add(LoadBookEvent(event.bookId));
      },
    );
  }

  Future<void> _onRemoveReadMetaEvent(
      RemoveReadMetaEvent event, Emitter<BookOptionsState> emit) async {
    emit(
      state.copyWith(requestStatus: RequestStatus.loading),
    );

    final result = await _removeReadMetaUsecase(event.bookId);

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          requestStatus: RequestStatus.error,
        ),
      ),
      (r) {
        add(LoadBookEvent(event.bookId));
      },
    );
  }

  Future<void> _onAddReadDateEvent(
      AddReadDateEvent event, Emitter<BookOptionsState> emit) async {
    emit(
      state.copyWith(requestStatus: RequestStatus.loading),
    );

    final params =
        AddReadDataDto(bookId: event.bookId, readDate: event.endDate);

    final result = await _addReadDateUsecase(params);

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          requestStatus: RequestStatus.error,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            requestStatus: RequestStatus.loaded,
          ),
        );
      },
    );
  }

  FutureOr<void> _onRemoveBookEvent(
      RemoveBookEvent event, Emitter<BookOptionsState> emit) async {
    emit(
      state.copyWith(requestStatus: RequestStatus.loading),
    );

    final result = await _removeBookUsecase(event.bookId);

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          requestStatus: RequestStatus.error,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            requestStatus: RequestStatus.loaded,
          ),
        );
      },
    );
  }
}
