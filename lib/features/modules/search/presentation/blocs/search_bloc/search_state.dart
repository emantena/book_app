// part of 'search_bloc.dart';

// enum SearchRequestStatus {
//   empty,
//   loading,
//   loaded,
//   error,
//   noResults,
// }

// class SearchState extends Equatable {
//   final List<SearchResultItem> searchResults;
//   final SearchRequestStatus status;
//   final String message;

//   const SearchState({
//     this.searchResults = const [],
//     this.status = SearchRequestStatus.empty,
//     this.message = '',
//   });

//   SearchState copyWith({
//     List<SearchResultItem>? searchResults,
//     SearchRequestStatus? status,
//     String? message,
//   }) {
//     return SearchState(
//       searchResults: searchResults ?? this.searchResults,
//       status: status ?? this.status,
//       message: message ?? this.message,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         searchResults,
//         status,
//         message,
//       ];
// }
