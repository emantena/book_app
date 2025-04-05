import 'package:flutter/material.dart';

import '../../book_options_action_button.dart';
import '../../../controllers/bloc/book_options_bloc.dart';
import '../../../../../../../core/domain/dto/shelf_item_dto.dart';
import '../../../../../../../core/domain/enums/reading_status.dart';
import '../../../../../../../core/resources/app_values.dart';
import '../../../../../../../core/utils/functions.dart';

class ChangeReadStatus extends StatelessWidget {
  const ChangeReadStatus({
    super.key,
    required this.bloc,
    required this.bookItem,
    required this.widthSize,
  });

  final BookOptionsBloc bloc;
  final ShelfItemDto bookItem;
  final double widthSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m16),
      child: BookOptionsActionButton(
        context: context,
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildListTile(
                        context, bloc, bookItem.bookId, ReadingStatus.read),
                    _buildListTile(context, bloc, bookItem.bookId,
                        ReadingStatus.wantToRead),
                    _buildListTile(
                        context, bloc, bookItem.bookId, ReadingStatus.reading),
                    _buildListTile(context, bloc, bookItem.bookId,
                        ReadingStatus.rereading),
                    _buildListTile(context, bloc, bookItem.bookId,
                        ReadingStatus.abandoned),
                  ],
                ),
              );
            },
          );
        },
        icon: Icon(
          Icons.bookmark,
          color: getColorByReadStatus(bookItem.readingStatus),
        ),
        width: widthSize * 0.45,
        height: 70,
        title: getTextByReadStatus(bookItem.readingStatus),
      ),
    );
  }
}

Widget _buildListTile(
  BuildContext context,
  BookOptionsBloc bloc,
  String bookId,
  ReadingStatus status,
) {
  return ListTile(
    leading: Icon(Icons.bookmark, color: getColorByReadStatus(status)),
    title: Text(getTextByReadStatus(status)),
    onTap: () async {
      bloc.add(ChangeReadingStatusEvent(status, bookId));
      Navigator.pop(context);
    },
  );
}
