import 'package:book_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/book_detail.dart';

abstract class IBookDetailRepository {
  Future<Either<Failure, BookDetail>> getBookDetails(String bookId);
}
