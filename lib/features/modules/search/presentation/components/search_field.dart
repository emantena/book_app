import 'package:book_app/core/resources/app_colors.dart';
import 'package:book_app/core/resources/app_strings.dart';
import 'package:book_app/core/resources/app_values.dart';
import 'package:book_app/features/modules/search/presentation/controllers/bloc/search_bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final inputTheme = Theme.of(context).inputDecorationTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p8),
      child: Form(
        child: TextFormField(
          controller: _textController,
          cursorColor: AppColors.primaryText,
          cursorWidth: AppSize.s1,
          style: textTheme.bodyLarge,
          onChanged: (title) {
            context.read<SearchBloc>().add(GetSearchResultsEvent(title));
          },
          decoration: InputDecoration(
            fillColor: Colors.grey.shade400,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.unselectedColor,
              ),
              borderRadius: BorderRadius.circular(AppSize.s45),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.unselectedColor,
              ),
              borderRadius: BorderRadius.circular(AppSize.s45),
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.unselectedColor,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                _textController.text = '';
                context.read<SearchBloc>().add(const GetSearchResultsEvent(''));
              },
              child: const Icon(
                Icons.clear_rounded,
                color: AppColors.unselectedColor,
              ),
            ),
            hintText: AppStrings.searchHint,
            hintStyle: inputTheme.hintStyle,
          ),
        ),
      ),
    );
  }
}
