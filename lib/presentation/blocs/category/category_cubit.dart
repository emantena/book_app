import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/category_list_usecase.dart';
import '../../../data/models/category_model.dart';
import '../../../domain/usecases/base_use_case.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryListUseCase _categoryListInUsecase;

  CategoryCubit(this._categoryListInUsecase) : super(const CategoryState());

  Future<void> loadCategories() async {
    final result = await _categoryListInUsecase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: CategoryRequestStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: CategoryRequestStatus.success,
          categories: r,
        ),
      ),
    );
  }
}
