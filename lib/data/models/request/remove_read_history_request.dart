class RemoveReadHistoryRequest {
  final String bookId;
  final String historyId;

  RemoveReadHistoryRequest(
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
