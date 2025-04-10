import 'package:dartz/dartz.dart';

import 'base_use_case.dart';
import '../../core/error/failure.dart';
import '../../core/storage/cache_client.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/category_repository.dart';

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
