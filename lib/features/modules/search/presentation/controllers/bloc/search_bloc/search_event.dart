part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class GetSearchResultsEvent extends SearchEvent {
  final String title;

  const GetSearchResultsEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class SearchByCategory extends SearchEvent {
  final String category;

  const SearchByCategory(this.category);

  @override
  List<Object> get props => [category];
}
