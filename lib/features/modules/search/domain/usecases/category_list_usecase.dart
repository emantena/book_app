import 'package:book_app/core/cache/cache_client.dart';
import 'package:book_app/core/firebase/models/category_model.dart';
import 'package:book_app/core/firebase/repository/category_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/data/error/failure.dart';
import '../../../../../core/domain/usecase/base_use_case.dart';

class CategoryListUseCase extends BaseUseCase<List<SubCategory>, NoParameters> {
  final ICategoryRepository _categoryRepository;
  final CacheClient _cacheClient;
  static const String categoryKey = '__categories__';

  CategoryListUseCase(this._categoryRepository, this._cacheClient);

  @override
  Future<Either<Failure, List<SubCategory>>> call(NoParameters p) async {
    try {
      final categories = _cacheClient.read(key: categoryKey) as List<SubCategory>?;

      if (categories != null) return Right(categories);

      final result = await _categoryRepository.list();
      final subCategories = result.expand((category) => category.subCategory ?? []).toList().cast<SubCategory>();

      _cacheClient.write(key: categoryKey, value: subCategories);

      return Right(subCategories);
    } catch (e) {
      return const Left(DatabaseFailure("Error"));
    }
  }
}
