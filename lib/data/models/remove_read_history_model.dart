class RemoveReadHistoryModel {
  final String bookId;
  final String historyId;

  RemoveReadHistoryModel(
    this.bookId,
    this.historyId,
  );

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'historyId': historyId,
    };
  }
}
