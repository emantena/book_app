import '../../../data/models/read_history_model.dart';

abstract class IReadHistoryRepository {
  Future<void> addReadHistory(
      ReadHistoryModel history, String bookId, String userId);
  Future<void> updateReadHistory(String historyId, String bookId, String userId,
      int currentPage, int currentPercent);
  Future<void> removeReadHistory(
      String historyId, String bookId, String userId);
  // Future<ReadHistoryDto?> getReadHistory(String userId, String bookId);
  // Future<List<ReadHistoryDto>> getAllReadHistories(String userId);
}
