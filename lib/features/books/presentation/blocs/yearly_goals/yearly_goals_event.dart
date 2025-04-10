part of 'yearly_goals_bloc.dart';

abstract class YearlyGoalsEvent extends Equatable {
  const YearlyGoalsEvent();

  @override
  List<Object?> get props => [];
}

class LoadBooksByYearEvent extends YearlyGoalsEvent {
  final int? targetYear;

  const LoadBooksByYearEvent(this.targetYear);

  @override
  List<Object?> get props => [targetYear];
}
