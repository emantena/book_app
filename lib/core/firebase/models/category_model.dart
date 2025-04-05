class CategoryModel {
  final String id;
  final String name;
  final bool active;
  List<SubCategory>? subCategory;

  CategoryModel({
    required this.id,
    required this.name,
    required this.active,
  });

  static CategoryModel fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? "",
      name: json['name'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'active': active};
}

class SubCategory {
  final String id;
  final String name;
  final bool active;
  final String color;

  SubCategory({
    required this.id,
    required this.name,
    required this.active,
    required this.color,
  });

  static SubCategory fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? "",
      name: json['name'],
      active: json['active'],
      color: json['color'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'active': active,
        'color': color,
      };
}
