import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/config/app_constants.dart';
import '../../core/error/failure.dart';
import '../../domain/interfaces/repositories/i_read_history_repository.dart';
import '../models/read_history_model.dart';

class ReadHistoryRepository implements IReadHistoryRepository {
  final FirebaseFirestore _firestore;

  ReadHistoryRepository(this._firestore);

  @override
  Future<void> addReadHistory(
    ReadHistoryModel history,
    String bookId,
    String userId,
  ) async {
    await _firestore
        .collection(FirebaseConstants.bookShelfCollection)
        .doc(userId)
        .collection(FirebaseConstants.booksCollection)
        .where('bookId', isEqualTo: bookId)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        throw const DatabaseFailure('Book not found');
      }

      final doc = value.docs.first;
      doc.reference.update({
        ShelfItemFields.readHistory: FieldValue.arrayUnion([history.toJson()])
      });
    });
  }

  @override
  Future<void> updateReadHistory(String historyId, String bookId, String userId,
      int currentPage, int currentPercent) async {
    await _firestore
        .collection(FirebaseConstants.bookShelfCollection)
        .doc(userId)
        .collection(FirebaseConstants.booksCollection)
        .where('bookId', isEqualTo: bookId)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        throw const DatabaseFailure('Book not found');
      }

      final doc = value.docs.first;

      final readHistory = (doc.get('readHistory') as List<dynamic>)
          .cast<Map<String, dynamic>>();

      final index =
          readHistory.indexWhere((element) => element['id'] == historyId);

      if (index == -1) {
        throw const DatabaseFailure('ReadHistory not found');
      }

      readHistory[index][ShelfItemFields.pages] = currentPage;
      readHistory[index][FirebaseConstants.percentageField] = currentPercent;

      await doc.reference.update({
        'readHistory': readHistory,
      });
    });
  }

  @override
  Future<void> removeReadHistory(
      String historyId, String bookId, String userId) async {
    final doc = await _firestore
        .collection(FirebaseConstants.bookShelfCollection)
        .doc(userId)
        .collection(FirebaseConstants.booksCollection)
        .where(ShelfItemFields.bookId, isEqualTo: bookId)
        .get()
        .then((value) => value.docs.first);

    if (!doc.exists) {
      throw const DatabaseFailure('Book not found');
    }

    final readHistory = (doc.get('readHistory') as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .where((element) => element['id'] != historyId)
        .toList();

    await doc.reference.update({
      'readHistory': readHistory,
    });
  }
}
