import 'dart:async';

import 'package:book_app/features/modules/search/domain/entities/search_result_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:book_app/features/modules/search/domain/usecases/search_usecase.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../domain/entities/request/search_request.dart';

part 'search_event.dart';
part 'search_state.dart';

const _duration = Duration(milliseconds: 600);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase _searchUseCase;

  SearchBloc(this._searchUseCase) : super(const SearchState()) {
    on<GetSearchResultsEvent>(_getSearchResults, transformer: debounce(_duration));
    on<SearchByCategory>(_searchByCategory);
  }

  Future<void> _getSearchResults(
    GetSearchResultsEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.title.trim().isEmpty) {
      return emit(
        state.copyWith(
          status: SearchRequestStatus.initial,
        ),
      );
    }

    emit(
      state.copyWith(
        status: SearchRequestStatus.loading,
      ),
    );

    final request = SearchRequest(title: event.title);

    final result = await _searchUseCase(request);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: SearchRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(
            state.copyWith(
              status: SearchRequestStatus.noResults,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: SearchRequestStatus.loaded,
              searchResults: r,
            ),
          );
        }
      },
    );
  }

  Future<void> _searchByCategory(
    SearchByCategory event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SearchRequestStatus.loading,
      ),
    );

    final request = SearchRequest(category: event.category);

    final result = await _searchUseCase(request);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: SearchRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(
            state.copyWith(
              status: SearchRequestStatus.noResults,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: SearchRequestStatus.loaded,
              searchResults: r,
            ),
          );
        }
      },
    );
  }
}
