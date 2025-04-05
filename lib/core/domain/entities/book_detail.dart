import 'package:book_app/core/domain/entities/image_links.dart';
import 'package:book_app/core/domain/entities/industry_identifier.dart';
import 'package:book_app/core/utils/functions.dart';
import 'package:equatable/equatable.dart';
// import 'package:google_books_api/google_books_api.dart' as google_books;

import '../enums/reading_status.dart';

class BookDetail extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String thumbnail;
  final List<String> author;
  final int totalPages;
  final String publishedDate;
  final String publisher;
  final String description;
  final List<IndustryIdentifier> industryIdentifiers;
  final ImageLinks imageLinks;
  final ReadingStatus? readingStatus;

  const BookDetail({
    this.id = '',
    this.title = '',
    this.subtitle = '',
    this.thumbnail = '',
    this.author = const [],
    this.totalPages = 0,
    this.publishedDate = '',
    this.publisher = '',
    this.description = '',
    this.industryIdentifiers = const [],
    this.imageLinks = const ImageLinks(),
    this.readingStatus,
  });

  factory BookDetail.fromJson(Map<String, dynamic> json) {
    return BookDetail(
      id: json['id'] ?? '',
      title: json['volumeInfo']['title'] ?? '',
      subtitle: json['volumeInfo']['subtitle'] ?? '',
      thumbnail: json['volumeInfo']['thumbnail'] ?? '',
      totalPages: json['volumeInfo']['pageCount'] ?? 0,
      publishedDate: json['volumeInfo']['publishedDate'] ?? '',
      description: removeAllHtmlTags(json['volumeInfo']['description']),
      readingStatus: null,
      author: json['volumeInfo']['authors'] == null
          ? []
          : List<String>.from(
              json['volumeInfo']['authors'].map((x) => x),
            ),
      publisher: json['volumeInfo']['publisher'] ?? '',
      industryIdentifiers: json['industryIdentifiers'] == null
          ? []
          : List<IndustryIdentifier>.from(
              json['industryIdentifiers'].map((x) => IndustryIdentifier.fromJson(x)),
            ),
      imageLinks: json['volumeInfo']['imageLinks'] == null
          ? const ImageLinks()
          : ImageLinks.fromJson(
              json['volumeInfo']['imageLinks'],
            ),
    );
  }

  String publisherYear() {
    if (publishedDate == '') {
      return '';
    }

    return publishedDate.substring(0, 4);
  }

  BookDetail copyWith(
      {String? id,
      String? title,
      String? subtitle,
      String? thumbnail,
      List<String>? author,
      int? totalPages,
      String? publishedDate,
      String? publisher,
      String? description,
      List<IndustryIdentifier>? industryIdentifiers,
      ImageLinks? imageLinks,
      ReadingStatus? readingStatus}) {
    return BookDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      thumbnail: thumbnail ?? this.thumbnail,
      author: author ?? this.author,
      totalPages: totalPages ?? this.totalPages,
      publishedDate: publishedDate ?? this.publishedDate,
      publisher: publisher ?? this.publisher,
      description: description ?? this.description,
      industryIdentifiers: industryIdentifiers ?? this.industryIdentifiers,
      imageLinks: imageLinks ?? this.imageLinks,
      readingStatus: readingStatus ?? this.readingStatus,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        thumbnail,
        author,
        totalPages,
        publishedDate,
        publisher,
        description,
        industryIdentifiers,
        imageLinks,
        readingStatus,
      ];
}
