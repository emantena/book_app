import 'package:book_app/features/modules/search/domain/entities/search_result_item.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:book_app/core/data/error/exceptions.dart';
import 'package:book_app/core/data/error/failure.dart';
import 'package:book_app/features/modules/search/data/datasource/search_remote_data_source.dart';
import 'package:book_app/features/modules/search/domain/repository/search_repository.dart';

class SearchRepository extends ISearchRepository {
  final ISearchRemoteDataSource _baseSearchRemoteDataSource;

  SearchRepository(this._baseSearchRemoteDataSource);

  @override
  Future<Either<Failure, List<SearchResultItem>>> search(String title) async {
    try {
      final result = await _baseSearchRemoteDataSource.search(title);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message ?? ''));
    }
  }

  @override
  Future<Either<Failure, List<SearchResultItem>>> searchCategory(String category) async {
    try {
      final result = await _baseSearchRemoteDataSource.searchCategory(category);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message ?? ''));
    }
  }
}
