import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/app_colors.dart';
import '../controllers/bloc/search_bloc/search_bloc.dart';
import '../controllers/cubit/category_list_cubit/category_cubit.dart';
import '../../../../presentation/components/loading_indicator.dart';

/// Widget que exibe uma grade de categorias de livros para seleção
class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    super.initState();
    final categoryCubit = context.read<CategoryCubit>();

    Future.microtask(() {
      categoryCubit.loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state.status == CategoryRequestStatus.success) {
          return _buildCategoryGrid(context, state);
        } else if (state.status == CategoryRequestStatus.initial) {
          return const Center(child: LoadingIndicator());
        } else {
          return const Center(
            child: Text('Não foi possível carregar as categorias'),
          );
        }
      },
    );
  }

  Widget _buildCategoryGrid(BuildContext context, CategoryState state) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 7 / 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      itemCount: state.categories.length,
      itemBuilder: (context, index) {
        final category = state.categories[index];
        return _buildCategoryCard(context, category);
      },
    );
  }

  Widget _buildCategoryCard(BuildContext context, dynamic category) {
    return SizedBox(
      child: Card(
        elevation: 0,
        color: AppColors.secondaryBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  context
                      .read<SearchBloc>()
                      .add(SearchByCategory(category.name));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
