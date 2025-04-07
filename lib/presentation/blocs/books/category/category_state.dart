part of 'category_cubit.dart';

enum CategoryRequestStatus {
  initial,
  success,
  error,
}

class CategoryState extends Equatable {
  final String? errorMessage;
  final CategoryRequestStatus status;
  final List<SubCategory> categories;

  const CategoryState({this.errorMessage, this.status = CategoryRequestStatus.initial, this.categories = const []});

  CategoryState copyWith({
    String? errorMessage = '',
    CategoryRequestStatus? status,
    List<SubCategory>? categories,
  }) {
    return CategoryState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        status,
        categories,
      ];
}
