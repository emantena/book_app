import 'package:book_app/core/domain/usecase/base_use_case.dart';
import 'package:book_app/features/modules/search/domain/entities/category_result_item.dart';
import 'package:dartz/dartz.dart';
import 'package:book_app/core/data/error/failure.dart';

import '../../domain/repository/category_repository.dart';
import '../datasource/category_data_source.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final ICategoryDataSource _categoryDataSource;

  CategoryRepositoryImpl(this._categoryDataSource);

  @override
  Future<Either<Failure, List<CategoryResultItem>>> list(NoParameters p) async {
    try {
      final result = await _categoryDataSource.list();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
