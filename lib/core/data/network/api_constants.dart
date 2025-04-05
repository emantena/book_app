const int maxResults = 40;

class ApiConstants {
  static const String apiKey = '';
  static const String baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  static const String language = 'pt-BR';
  // search paths
  static String getSearchPath(String title) {
    return '$baseUrl?q=$title&maxResults=$maxResults&langRestrict=$language';
  }

  static String getSearchCategory(String category) {
    return '$baseUrl?q=subject:$category&maxResults=$maxResults&langRestrict=$language';
  }

  static String getBookDetailPath(String bookId) {
    return '$baseUrl/$bookId';
  }

  static String noImage =
      "https://firebasestorage.googleapis.com/v0/b/book-club-4fe07.appspot.com/o/assets%2Fno-image.png?alt=media&token=e18fc6be-5f24-4e7d-82e9-6bb331afe806";
  static String notFound =
      "https://firebasestorage.googleapis.com/v0/b/book-club-4fe07.appspot.com/o/assets%2Fnot-found.png?alt=media&token=3f6302ca-0953-479d-bc02-18ae1b17d02c";
}
