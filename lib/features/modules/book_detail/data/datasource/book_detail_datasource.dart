import 'package:book_app/core/data/error/exceptions.dart';
import 'package:book_app/core/data/network/api_constants.dart';
import 'package:book_app/core/data/network/error_message_model.dart';
import 'package:book_app/core/domain/entities/book_detail.dart';
import 'package:dio/dio.dart';

abstract class IBookDetailDatasource {
  Future<BookDetail> getBookDetails(String bookId);
}

class BookDetailDatasource implements IBookDetailDatasource {
  @override
  Future<BookDetail> getBookDetails(String bookId) async {
    final response = await Dio().get(ApiConstants.getBookDetailPath(bookId));

    if (response.statusCode == 200) {
      return BookDetail.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
