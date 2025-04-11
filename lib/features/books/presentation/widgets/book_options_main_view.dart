import 'package:book_app/features/books/presentation/widgets/actions/read_date/read_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'actions/read_meta/read_meta.dart';
import 'actions/remove_book/remove_book.dart';
import 'actions/read_history/read_history.dart';
import 'actions/read_status/change_read_status.dart';
import '../blocs/book_options/book_options_bloc.dart';
import '../../../../core/ui/components/read_indicator.dart';
import '../../../../core/ui/components/image_with_shimmer.dart';
import '../../../../data/models/dto/shelf_item_dto.dart';
import '../../../../domain/entities/reading_status.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_values.dart';

class BookOptionsMainView extends StatelessWidget {
  final ShelfItemDto bookItem;

  const BookOptionsMainView({super.key, required this.bookItem});

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final bloc = context.read<BookOptionsBloc>();

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryBackground,
                        borderRadius: BorderRadius.circular(AppSize.s8),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: widthSize * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: AppPadding.p8,
                                left: AppPadding.p16,
                                bottom: AppPadding.p8,
                                right: AppPadding.p16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bookItem.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: AppSize.s16,
                                      color: AppColors.primaryText,
                                    ),
                                  ),
                                  if (bookItem.endDate != null) ...[
                                    const SizedBox(height: AppSize.s4),
                                    Text(
                                      'Finalizado em: ${DateFormat('dd/MM/yyyy').format(bookItem.endDate!)}',
                                      style: const TextStyle(
                                        fontSize: AppSize.s14,
                                        color: AppColors.secondaryText,
                                      ),
                                    ),
                                  ],
                                  if (bookItem.readingStatus ==
                                      ReadingStatus.reading) ...{
                                    ReadIndicator(
                                      totalPagesToRead: bookItem.pages,
                                      totalReadPages: bookItem.currentPage,
                                    ),
                                  }
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppPadding.p8,
                              left: AppPadding.p14,
                              bottom: AppPadding.p8,
                              right: AppPadding.p14,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s8),
                              child: ImageWithShimmer(
                                width: 68,
                                height: double.infinity,
                                imageUrl: bookItem.imageUrl,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChangeReadStatus(
                          bloc: bloc,
                          bookItem: bookItem,
                          widthSize: widthSize,
                        ),
                        ReadHistory(
                          bloc: bloc,
                          bookItem: bookItem,
                          widthSize: widthSize,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReadMeta(
                          bloc: bloc,
                          bookItem: bookItem,
                          widthSize: widthSize,
                        ),
                        ReadDate(
                          bloc: bloc,
                          bookItem: bookItem,
                          widthSize: widthSize,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RemoveBook(
                          bloc: bloc,
                          bookItem: bookItem,
                          widthSize: widthSize,
                        ),
                      ],
                    )
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
