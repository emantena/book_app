import 'package:book_app/core/error/failure.dart';
import 'package:book_app/domain/usecases/base_use_case.dart';
import 'package:dartz/dartz.dart';

import '../../entities/category_result_item.dart';

abstract class ICategoryRepository {
  Future<Either<Failure, List<CategoryResultItem>>> list(NoParameters p);
}
