import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/reading_status.dart';
import '../models/book_shelf_model.dart';
import '../models/dto/book_shelf_dto.dart';
import '../models/dto/read_history_dto.dart';
import '../models/dto/shelf_item_dto.dart';
import '../models/shelf_item_model.dart';

abstract class IBookShelfRepository {
  Future<bool> addBook(ShelfItemModel shelfItem, String userId);
  Future<BookShelfDto> getBookShelf(String userId);
  Future<BookShelfDto> getBookShelfByReadingStatus(
      String userId, ReadingStatus status);
  Future<bool> existBookShelf({required String userId});
  Future<void> createBookShelf({required String userId});
  Future<void> updateBook(ShelfItemModel shelfItem, String userId);
  Future<void> updatePagesRead(String userId, int pages);
  Future<void> deleteBook(String userId, String bookId);
}

class BookShelfRepository extends IBookShelfRepository {
  static const bookShelfCollection = 'book_shelf';
  static const booksCollection = 'books';

  final FirebaseFirestore _firestore;

  BookShelfRepository(this._firestore);

  @override
  Future<bool> addBook(ShelfItemModel shelfItem, String userId) async {
    try {
      await _firestore
          .collection(bookShelfCollection)
          .doc(userId)
          .collection(booksCollection)
          .add(shelfItem.toJson());
      return true;
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<BookShelfDto> getBookShelf(String userId) async {
    try {
      final bookShelfDoc =
          await _firestore.collection(bookShelfCollection).doc(userId).get();

      if (!bookShelfDoc.exists) {
        return BookShelfDto(pagesRead: 0, books: []);
      }

      final booksQuerySnapshot = await _firestore
          .collection(bookShelfCollection)
          .doc(userId)
          .collection(booksCollection)
          .get();

      final books = _mapQuerySnapshotToShelfItems(booksQuerySnapshot);

      return BookShelfDto(
        pagesRead: bookShelfDoc.data()?['pagesRead'] ?? 0,
        books: books,
      );
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<bool> existBookShelf({required String userId}) async {
    var result =
        await _firestore.collection(bookShelfCollection).doc(userId).get();

    return result.exists;
  }

  @override
  Future<void> createBookShelf({required String userId}) async {
    const newBookShelf = BookShelfModel(pagesRead: 0);

    await _firestore
        .collection(bookShelfCollection)
        .doc(userId)
        .set(newBookShelf.toJson());
  }

  @override
  Future<BookShelfDto> getBookShelfByReadingStatus(
      String userId, ReadingStatus status) async {
    try {
      final bookShelfDoc =
          await _firestore.collection(bookShelfCollection).doc(userId).get();

      if (!bookShelfDoc.exists) {
        return BookShelfDto(pagesRead: 0, books: []);
      }

      final booksQuerySnapshot = await _firestore
          .collection(bookShelfCollection)
          .doc(userId)
          .collection(booksCollection)
          .where('readingStatus', isEqualTo: status.index)
          .get();

      final books = _mapQuerySnapshotToShelfItems(booksQuerySnapshot);

      return BookShelfDto(
        pagesRead: bookShelfDoc.data()?['pagesRead'] ?? 0,
        books: books,
      );
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<void> updateBook(ShelfItemModel shelfItem, String userId) async {
    try {
      final bookDoc = await _firestore
          .collection(bookShelfCollection)
          .doc(userId)
          .collection(booksCollection)
          .where('bookId', isEqualTo: shelfItem.bookId)
          .get()
          .then((value) => value.docs.first);

      if (!bookDoc.exists) {
        throw const DatabaseFailure('Book not found');
      }

      await bookDoc.reference.update(shelfItem.toJson());
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<void> updatePagesRead(String userId, int pages) async {
    await _firestore.collection(bookShelfCollection).doc(userId).get().then(
      (value) {
        if (!value.exists) {
          throw const DatabaseFailure('BookShelf not found');
        }

        final bookShelf = BookShelfModel.fromJson(value.data()!);
        final totalPages = bookShelf.pagesRead + pages;

        value.reference.update({
          'pagesRead': totalPages,
        });
      },
    );
  }

  @override
  Future<void> deleteBook(String userId, String bookId) async {
    final bookDoc = await _firestore
        .collection(bookShelfCollection)
        .doc(userId)
        .collection(booksCollection)
        .where('bookId', isEqualTo: bookId)
        .get();

    if (bookDoc.docs.isEmpty) {
      throw const DatabaseFailure('Book not found');
    }

    await bookDoc.docs.first.reference.delete();
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
