import 'package:book_app/data/models/read_meta_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/config/app_constants.dart';
import '../../core/error/failure.dart';
import '../../domain/interfaces/repositories/i_read_meta_repository.dart';
import '../models/dto/shelf_item_dto.dart';
import '../models/shelf_item_model.dart';

class ReadMetaRepository implements IReadMetaRepository {
  final FirebaseFirestore _firestore;

  ReadMetaRepository(this._firestore);

  @override
  Future<List<ShelfItemDto>> getBooksByYearTarget(
      int? targetYear, String userId) async {
    final booksSnapshot = await _firestore
        .collection(FirebaseConstants.bookShelfCollection)
        .doc(userId)
        .collection(FirebaseConstants.booksCollection)
        .get();

    final List<ShelfItemDto> booksWithMeta = [];

    for (var doc in booksSnapshot.docs) {
      final bookData = doc.data();
      if (bookData.containsKey('readMeta') && bookData['readMeta'] != null) {
        final readMeta = ReadMetaModel.fromJson(bookData['readMeta']);

        // Se targetYear for null (Não sei) ou corresponder ao ano alvo
        if ((targetYear == null && readMeta.targetYear == null) ||
            readMeta.targetYear == targetYear) {
          final shelfItem = ShelfItemModel.fromJson(bookData);
          final shelfItemDto = ShelfItemDto.fromModel(shelfItem);
          booksWithMeta.add(shelfItemDto);
        }
      }
    }

    return booksWithMeta;
  }

  @override
  Future<void> removeReadMeta(String bookId, String userId) async {
    await _firestore
        .collection(FirebaseConstants.bookShelfCollection)
        .doc(userId)
        .collection(FirebaseConstants.booksCollection)
        .where(ShelfItemFields.bookId, isEqualTo: bookId)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        throw const DatabaseFailure('Book not found');
      }

      final doc = value.docs.first;
      doc.reference.update({
        'readMeta': FieldValue.delete(),
      });
    });
  }

  @override
  Future<void> setReadMeta(
      String bookId, String userId, ReadMetaModel readMeta) async {
    await _firestore
        .collection(FirebaseConstants.bookShelfCollection)
        .doc(userId)
        .collection(FirebaseConstants.booksCollection)
        .where(ShelfItemFields.bookId, isEqualTo: bookId)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        throw const DatabaseFailure('Book not found');
      }

      final doc = value.docs.first;
      doc.reference.update({
        'readMeta': readMeta.toJson(),
      });
    });
  }
}
