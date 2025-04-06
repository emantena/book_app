import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/data/error/exceptions.dart';
import '../../core/data/error/failure.dart';
import '../../domain/entities/book_detail.dart';
import '../../domain/interfaces/repositories/i_book_detail_repository.dart';
import '../sources/book_detail_datasource.dart';

class BookDetailsRepository extends IBookDetailRepository {
  final IBookDetailDatasource _datasource;

  BookDetailsRepository(this._datasource);

  @override
  Future<Either<Failure, BookDetail>> getBookDetails(String bookId) async {
    try {
      final result = await _datasource.getBookDetails(bookId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message ?? ''));
    }
  }
}
