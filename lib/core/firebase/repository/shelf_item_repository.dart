import 'package:book_app/core/domain/dto/shelf_item_dto.dart';
import 'package:book_app/core/domain/enums/reading_status.dart';
import 'package:book_app/core/resources/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/error/failure.dart';
import '../../domain/dto/read_history_dto.dart';
import '../models/shelf_item.dart';
import 'interfaces/i_shelf_item_repository.dart';

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
        .map((doc) => ShelfItem.fromJson(doc.data()))
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
