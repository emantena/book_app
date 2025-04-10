import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/enum_types.dart';
import '../../../../../data/models/dto/shelf_item_dto.dart';
import '../../../../../domain/usecases/get_books_by_year_target_usecase.dart';

part 'yearly_goals_event.dart';
part 'yearly_goals_state.dart';

class YearlyGoalsBloc extends Bloc<YearlyGoalsEvent, YearlyGoalsState> {
  final GetBooksByYearTargetUsecase _getBooksByYearTargetUsecase;

  YearlyGoalsBloc(this._getBooksByYearTargetUsecase) : super(const YearlyGoalsState()) {
    on<LoadBooksByYearEvent>(_onLoadBooksByYear);
  }

  Future<void> _onLoadBooksByYear(LoadBooksByYearEvent event, Emitter<YearlyGoalsState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final result = await _getBooksByYearTargetUsecase(event.targetYear);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (books) => emit(
        state.copyWith(
          status: RequestStatus.loaded,
          books: books,
          currentYear: event.targetYear,
        ),
      ),
    );
  }
}
