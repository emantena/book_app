import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/app_colors.dart';
import '../../../../../core/config/app_values.dart';
import '../../../../../core/ui/components/image_with_shimmer.dart';
import '../../../../../core/ui/components/read_indicator.dart';
import '../../../../../data/models/dto/shelf_item_dto.dart';
import '../../../../../domain/entities/reading_status.dart';
import '../../../../../presentation/blocs/books/book_options/book_options_bloc.dart';
import 'actions/read_history/read_history.dart';
import 'actions/read_status/change_read_status.dart';
import 'book_options_action_button.dart';

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
                        color: Colors.blueGrey.shade100,
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
                                  if (bookItem.readingStatus == ReadingStatus.reading) ...{
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
                        Container(
                          margin: const EdgeInsets.only(top: AppMargin.m16),
                          child: BookOptionsActionButton(
                            context: context,
                            onTap: () {},
                            icon: const Icon(
                              Icons.calendar_month_sharp,
                            ),
                            width: widthSize * 0.45,
                            height: 70,
                            title: 'Meta de leitura',
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: AppMargin.m16),
                          child: BookOptionsActionButton(
                            context: context,
                            icon: const Icon(Icons.event_available_rounded),
                            onTap: () {},
                            width: widthSize * 0.45,
                            height: 70,
                            title: 'Data de Leitura',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: AppMargin.m16),
                          child: BookOptionsActionButton(
                            context: context,
                            onTap: () {},
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                            ),
                            width: widthSize * 0.9,
                            height: 70,
                            title: 'Remover',
                          ),
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
