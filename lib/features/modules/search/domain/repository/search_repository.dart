import 'package:book_app/core/data/error/failure.dart';
import 'package:book_app/features/modules/search/domain/entities/search_result_item.dart';
import 'package:dartz/dartz.dart';

abstract class ISearchRepository {
  Future<Either<Failure, List<SearchResultItem>>> search(String title);
  Future<Either<Failure, List<SearchResultItem>>> searchCategory(String category);
}
