import 'package:book_app/core/data/error/exceptions.dart';
import 'package:book_app/core/data/network/api_constants.dart';
import 'package:book_app/core/data/network/error_message_model.dart';
import 'package:book_app/features/modules/search/data/models/search_result_item_model.dart';
import 'package:dio/dio.dart';

abstract class ISearchRemoteDataSource {
  Future<List<SearchResultItemModel>> search(String title);
  Future<List<SearchResultItemModel>> searchCategory(String category);
}

class SearchRemoteDataSource extends ISearchRemoteDataSource {
  @override
  Future<List<SearchResultItemModel>> search(String title) async {
    final response = await Dio().get(ApiConstants.getSearchPath(title));

    if (response.statusCode == 200) {
      if (response.data['items'] == null) return [];

      return List<SearchResultItemModel>.from(
        (response.data['items'] as List).map(
          (e) => SearchResultItemModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<SearchResultItemModel>> searchCategory(String category) async {
    final response = await Dio().get(ApiConstants.getSearchCategory(category));

    if (response.statusCode == 200) {
      if (response.data['items'] == null) return [];

      return List<SearchResultItemModel>.from(
        (response.data['items'] as List).map(
          (e) => SearchResultItemModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
