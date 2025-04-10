import 'package:flutter/material.dart';

import '../../book_options_action_button.dart';
import '../../../blocs/book_options/book_options_bloc.dart';
import '../../../../../../core/config/app_values.dart';
import '../../../../../../data/models/dto/shelf_item_dto.dart';

class RemoveBook extends StatelessWidget {
  final BookOptionsBloc bloc;
  final ShelfItemDto bookItem;
  final double widthSize;

  const RemoveBook({
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
        icon: const Icon(
          Icons.delete_forever_outlined,
        ),
        onTap: () {
          _showDeleteConfirmationDialog(
              context: context, bookId: bookItem.bookId);
        },
        width: widthSize * 0.9,
        height: 70,
        title: 'Remover',
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      {required BuildContext context, required String bookId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text(
            'Tem certeza de que deseja excluir este livro? Esta ação não pode ser desfeita.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                bloc.add(
                  RemoveBookEvent(bookId),
                );
                Navigator.of(context).pop();
              },
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
