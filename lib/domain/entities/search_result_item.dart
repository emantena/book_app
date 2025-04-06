import 'package:equatable/equatable.dart';

class SearchResultItem extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final List<String> author;
  final int totalPages;
  final String publishedDate;
  final String thumbnail;

  const SearchResultItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.totalPages,
    required this.publishedDate,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        author,
        totalPages,
        publishedDate,
        thumbnail,
      ];
}
