import 'package:book_app/core/firebase/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ICategoryRepository {
  Future<List<CategoryModel>> list();
}

class CategoryRepository implements ICategoryRepository {
  static const categoryCollection = 'categories';
  static const subCategoryCollection = 'subcategories';

  final FirebaseFirestore _firestore;

  CategoryRepository(this._firestore);

  @override
  Future<List<CategoryModel>> list() async {
    final categoriesCollection =
        await _firestore.collection(categoryCollection).get();
    final categories = <CategoryModel>[];

    for (var categoryDoc in categoriesCollection.docs) {
      final subCategories =
          await categoryDoc.reference.collection(subCategoryCollection).get();

      final category = CategoryModel.fromJson(categoryDoc.data());

      category.subCategory = subCategories.docs.map((e) {
        return SubCategory.fromJson(e.data());
      }).toList();

      categories.add(category);
    }

    return categories;
  }
}
