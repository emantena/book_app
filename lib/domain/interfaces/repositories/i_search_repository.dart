import 'package:dartz/dartz.dart';

import '../../../core/data/error/failure.dart';
import '../../entities/search_result_item.dart';

abstract class ISearchRepository {
  Future<Either<Failure, List<SearchResultItem>>> search(String title);
  Future<Either<Failure, List<SearchResultItem>>> searchCategory(String category);
}
