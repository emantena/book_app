import '../../../../core/domain/enums/reading_status.dart';

class ChangeReadStatusRequest {
  final String bookId;
  final ReadingStatus readingStatus;

  ChangeReadStatusRequest({required this.bookId, required this.readingStatus});
}
