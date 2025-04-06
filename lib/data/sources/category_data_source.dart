abstract class ICategoryDataSource {
  Future list();
}

class CategoryDataSource extends ICategoryDataSource {
  @override
  Future list() async {
    // final response = await Dio().get(ApiConstants.getSearchPath());

    // if (response.statusCode == 200) {
    //   return List<SearchResultItemModel>.from(
    //     (response.data['items'] as List).map(
    //       (e) => SearchResultItemModel.fromJson(e),
    //     ),
    //   );
    // } else {
    //   throw ServerException(
    //     errorMessageModel: ErrorMessageModel.fromJson(response.data),
    //   );
    // }
  }
}
