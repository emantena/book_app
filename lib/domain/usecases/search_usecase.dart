import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/search_request.dart';
import '../entities/search_result_item.dart';
import '../interfaces/repositories/i_search_repository.dart';
import 'base_use_case.dart';

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
