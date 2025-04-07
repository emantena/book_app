import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/config/app_values.dart';
import '../../../../../../../core/ui/components/read_indicator.dart';
import '../../../../../../../data/models/dto/read_history_dto.dart';
import '../../../../../../../data/models/dto/shelf_item_dto.dart';
import '../../../../../../../presentation/blocs/books/book_options/book_options_bloc.dart';
import '../../../../../../../presentation/pages/books/book_options/components/edit_history_modal.dart';
import '../../book_options_action_button.dart';

class ReadMeta extends StatelessWidget {
  final BookOptionsBloc bloc;
  final ShelfItemDto bookItem;
  final double widthSize;

  const ReadMeta({
    super.key,
    required this.bloc,
    required this.bookItem,
    required this.widthSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m16),
      child: BookOptionsActionButton(
        context: context,
        icon: const Icon(Icons.history_outlined),
        onTap: () => _showMetaBottomSheet(context, bloc, bookItem),
        width: widthSize * 0.45,
        height: 70,
        title: 'Histórico',
      ),
    );
  }

  void _showMetaBottomSheet(
    BuildContext context,
    BookOptionsBloc bloc,
    ShelfItemDto bookItem,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.95,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Meta de Leitura',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: bookItem.readHistory.length,
                      itemBuilder: (ctx, index) {
                        final formattedDate = DateFormat('dd/MM/yyyy').format(bookItem.readHistory[index].dateRead);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(formattedDate),
                                    IconButton(
                                      onPressed: () {
                                        _showHistoryOptionsBottomSheet(
                                          context,
                                          bloc,
                                          bookItem.readHistory[index],
                                        );
                                      },
                                      icon: const Icon(Icons.more_vert),
                                    ),
                                  ],
                                ),
                                ReadIndicator(
                                  totalPagesToRead: bookItem.pages,
                                  totalReadPages: bookItem.readHistory[index].pages!,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showHistoryOptionsBottomSheet(
    BuildContext context,
    BookOptionsBloc bloc,
    ReadHistoryDto history,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Editar'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return EditHistoryModal(
                      bloc: bloc,
                      history: history,
                      totalPages: bookItem.pages,
                    );
                  },
                );
              },
            ),
            ListTile(
              title: const Text('Excluir'),
              onTap: () {
                // bloc.add(DeleteReadHistoryEvent(history))
              },
            ),
          ],
        );
      },
    );
  }
}
