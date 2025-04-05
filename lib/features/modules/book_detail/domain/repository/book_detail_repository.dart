import 'package:book_app/core/data/error/failure.dart';
import 'package:book_app/core/domain/entities/book_detail.dart';
import 'package:dartz/dartz.dart';

abstract class IBookDetailRepository {
  Future<Either<Failure, BookDetail>> getBookDetails(String bookId);
}
