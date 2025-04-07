import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/app_values.dart';
import '../../../../core/ui/components/error_text.dart';
import '../../../../core/ui/components/loading_indicator.dart';
import '../../../../core/ui/components/vertical_listview_card.dart';
import '../widgets/category_list.dart';
import '../widgets/no_results.dart';
import '../widgets/search_field.dart';
import '../bloc/search/search_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchWidget();
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: AppPadding.p12,
            left: AppPadding.p16,
            right: AppPadding.p16,
          ),
          child: Column(
            children: [
              const SearchField(),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  switch (state.status) {
                    case SearchRequestStatus.initial:
                      return const Expanded(child: CategoryList());
                    case SearchRequestStatus.empty:
                      return const NoResults();
                    case SearchRequestStatus.loading:
                      return const Expanded(child: LoadingIndicator());
                    case SearchRequestStatus.loaded:
                      // FocusScope.of(context).unfocus();
                      return Expanded(
                        child: ListView.separated(
                          itemCount: state.searchResults.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: AppSize.s10);
                          },
                          itemBuilder: (context, index) {
                            return VerticalListviewCard(
                              id: state.searchResults[index].id,
                              title: state.searchResults[index].title,
                              author: state.searchResults[index].author,
                              thumbnail: state.searchResults[index].thumbnail,
                              totalPages: state.searchResults[index].totalPages,
                              subtitle: state.searchResults[index].subtitle,
                              publisherDate: state.searchResults[index].publishedDate,
                            );
                          },
                        ),
                      );
                    case SearchRequestStatus.error:
                      return const Expanded(child: ErrorText());
                    case SearchRequestStatus.noResults:
                      return const NoResults();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
