class CategoryResultItem {
  final String id;
  final String name;
  final bool active;
  final List<SubCategoryResultItem> subCategories;

  CategoryResultItem({
    required this.id,
    required this.name,
    required this.active,
    required this.subCategories,
  });
}

class SubCategoryResultItem {
  final String id;
  final String name;
  final bool active;

  SubCategoryResultItem({
    required this.id,
    required this.name,
    required this.active,
  });
}
