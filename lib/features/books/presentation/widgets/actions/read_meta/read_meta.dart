import 'package:flutter/material.dart';

import '../../../../../../../core/config/app_values.dart';
import '../../../../../../../data/models/dto/shelf_item_dto.dart';
import '../../../blocs/book_options/book_options_bloc.dart';
import '../../book_options_action_button.dart';
import 'new_read_meta_modal.dart';

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
        icon: const Icon(Icons.calendar_month_sharp),
        onTap: () => _showYearSelectionModal(context, bloc, bookItem),
        width: widthSize * 0.45,
        height: 70,
        title: 'Meta anual',
      ),
    );
  }

  void _showYearSelectionModal(
    BuildContext context,
    BookOptionsBloc bloc,
    ShelfItemDto bookItem,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return NewReadMetaModal(
          bloc: bloc,
          bookItem: bookItem,
        );
      },
    );
  }
}
