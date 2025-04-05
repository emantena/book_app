import 'package:book_app/features/modules/search/domain/entities/search_result_item.dart';
import 'package:dartz/dartz.dart';
import 'package:book_app/core/data/error/failure.dart';
import 'package:book_app/core/domain/usecase/base_use_case.dart';
import 'package:book_app/features/modules/search/domain/repository/search_repository.dart';

import '../entities/request/search_request.dart';

class SearchUseCase extends BaseUseCase<List<SearchResultItem>, SearchRequest> {
  final ISearchRepository _baseSearchRepository;

  SearchUseCase(this._baseSearchRepository);

  @override
  Future<Either<Failure, List<SearchResultItem>>> call(SearchRequest p) async {
    if (p.title.trim().isNotEmpty) {
      return await _baseSearchRepository.search(p.title);
    } else if (p.category.trim().isNotEmpty) {
      return await _baseSearchRepository.searchCategory(p.category);
    } else {
      return const Left(ServerFailure('Title or category is empty'));
    }
  }
}
