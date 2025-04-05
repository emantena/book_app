import 'package:book_app/features/modules/book_detail/data/datasource/book_detail_datasource.dart';
import 'package:book_app/features/modules/book_detail/domain/repository/book_detail_repository.dart';
import 'package:book_app/core/data/error/exceptions.dart';
import 'package:book_app/core/data/error/failure.dart';
import 'package:book_app/core/domain/entities/book_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

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
