import 'package:book_app/core/utils/functions.dart';

import '../../core/network/api_constants.dart';
import '../../domain/entities/search_result_item.dart';

class SearchResultItemModel extends SearchResultItem {
  const SearchResultItemModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.author,
    required super.totalPages,
    required super.publishedDate,
    required super.thumbnail,
  });

  factory SearchResultItemModel.fromJson(Map<String, dynamic> json) {
    final imageLinks = json['volumeInfo']['imageLinks'] != null ? ImageLinks.fromJson(json['volumeInfo']['imageLinks']) : null;

    return SearchResultItemModel(
      id: json['id'],
      title: json['volumeInfo']['title'] ?? '',
      subtitle: json['volumeInfo']['subtitle'] ?? '',
      totalPages: json['volumeInfo']['pageCount'] ?? 0,
      author: json['volumeInfo']['authors'] != null ? json['volumeInfo']['authors'].cast<String>() : const [],
      publishedDate: json['volumeInfo']['publishedDate'] ?? '',
      thumbnail: imageLinks?.thumbnail ?? ApiConstants.noImage,
    );
  }
}

class ImageLinks {
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  ImageLinks.fromJson(Map<String, dynamic> json) {
    smallThumbnail = getImageWithoutCurl(json['smallThumbnail']);
    thumbnail = getImageWithoutCurl(json['thumbnail']);
  }
}
