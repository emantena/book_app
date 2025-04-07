import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/config/app_constants.dart';
import '../../core/error/failure.dart';
import '../../domain/entities/reading_status.dart';
import '../../domain/interfaces/repositories/i_shelf_item_repository.dart';
import '../models/dto/read_history_dto.dart';
import '../models/shelf_item_model.dart';
import '../models/dto/shelf_item_dto.dart';

class ShelfItemRepository implements IShelfItemRepository {
  final FirebaseFirestore _firestore;

  ShelfItemRepository(this._firestore);

  @override
  Future<void> updatePagesRead(
      String bookId, String userId, int pagesRead) async {
    await _firestore
        .collection(FirebaseConstants.bookShelfCollection)
        .doc(userId)
        .collection(FirebaseConstants.booksCollection)
        .where(FirebaseConstants.bookIdField, isEqualTo: bookId)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        throw const DatabaseFailure('Book not found');
      }

      final doc = value.docs.first;
      doc.reference.update({
        FirebaseConstants.currentPageField: pagesRead,
      });
    });
  }

  @override
  Future<void> updateReadStatus(
    String bookId,
    String userId,
    DateTime? startDate,
    DateTime? endDate,
    ReadingStatus status,
  ) async {
    await _firestore
        .collection(FirebaseConstants.bookShelfCollection)
        .doc(userId)
        .collection(FirebaseConstants.booksCollection)
        .where(FirebaseConstants.bookIdField, isEqualTo: bookId)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        throw const DatabaseFailure('Book not found');
      }

      final doc = value.docs.first;
      doc.reference.update({
        FirebaseConstants.currentPageField: status,
        FirebaseConstants.startDateField: startDate,
        FirebaseConstants.endDateField: endDate,
      });
    });
  }

  @override
  Future<ShelfItemDto?> getShelfItemById(String bookId, String userId) async {
    final shelfItem = await _firestore
        .collection(FirebaseConstants.bookShelfCollection)
        .doc(userId)
        .collection(FirebaseConstants.booksCollection)
        .where('bookId', isEqualTo: bookId)
        .get();

    if (shelfItem.docs.isEmpty) {
      return null;
    }

    final book = _mapQuerySnapshotToShelfItems(shelfItem);

    return book.first;
  }

  List<ShelfItemDto> _mapQuerySnapshotToShelfItems(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((doc) => ShelfItemModel.fromJson(doc.data()))
        .map(
          (book) => ShelfItemDto(
            title: book.title,
            bookId: book.bookId,
            imageUrl: book.imageUrl,
            pages: book.pages,
            readingStatus: book.readingStatus,
            startDate: book.startDate,
            endDate: book.endDate,
            currentPage: book.currentPage,
            readHistory: book.readHistory
                    ?.map(
                      (e) => ReadHistoryDto(
                        book.bookId,
                        e.id,
                        e.readDate,
                        e.page,
                        e.percentage,
                        e.note,
                      ),
                    )
                    .toList() ??
                [],
          ),
        )
        .toList();
  }
}
