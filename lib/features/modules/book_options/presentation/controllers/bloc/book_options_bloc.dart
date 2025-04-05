import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/load_book_usecase.dart';
import '../../../models/change_read_status_request.dart';
import '../../../domain/usecase/set_read_history_usecase.dart';
import '../../../domain/usecase/change_read_status_usecase.dart';
import '../../../domain/usecase/delete_read_history_usecase.dart';
import '../../../../../../core/utils/functions.dart';
import '../../../../../../core/utils/enum.dart';
import '../../../../../../core/domain/dto/shelf_item_dto.dart';
import '../../../../../../core/domain/dto/read_history_dto.dart';
import '../../../../../../core/domain/enums/reading_status.dart';
import '../../../models/remove_read_history_model.dart';

part 'book_options_state.dart';
part 'book_options_event.dart';

class BookOptionsBloc extends Bloc<BookOptionsEvent, BookOptionsState> {
  final LoadBookUsecase _loadBookUsecase;
  final ChangeReadStatusUsecase _changeReadingStatusUsecase;
  final SetReadHistoryUsecase _readHistoryUsecase;
  final DeleteReadHistoryUsecase _deleteReadHistoryUsecase;

  BookOptionsBloc(
    this._loadBookUsecase,
    this._changeReadingStatusUsecase,
    this._readHistoryUsecase,
    this._deleteReadHistoryUsecase,
  ) : super(const BookOptionsState()) {
    on<LoadBookEvent>(_onLoadBookEvent);
    on<ChangeReadingStatusEvent>(_onChangeReadingStatusEvent);
    on<DeleteReadHistoryEvent>(_onDeleteReadHistoryEvent);
    on<SetReadMetaEvent>(_onSetReadMetaEvent);
    on<AddReadDateEvent>(_onAddReadDateEvent);
    on<SetReadHistoryEvent>(_onSetReadHistoryEvent);
    on<RemoveBookEvent>(_onRemoveBookEvent);
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
        RemoveReadHistoryModel(event.bookId, event.historyId));

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

  FutureOr<void> _onAddReadDateEvent(
      AddReadDateEvent event, Emitter<BookOptionsState> emit) {}

  FutureOr<void> _onSetReadMetaEvent(
      SetReadMetaEvent event, Emitter<BookOptionsState> emit) {}

  FutureOr<void> _onRemoveBookEvent(
      RemoveBookEvent event, Emitter<BookOptionsState> emit) {}
}
