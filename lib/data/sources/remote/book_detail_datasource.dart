import 'package:dio/dio.dart';
import 'package:book_app/core/error/exceptions.dart';

import '../../../core/network/api_constants.dart';
import '../../../core/network/error_message_model.dart';
import '../../../domain/entities/book_detail.dart';

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
