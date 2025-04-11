import 'package:flutter/material.dart';

import '../../book_options_action_button.dart';
import '../../../blocs/book_options/book_options_bloc.dart';
import '../../../../../../core/config/app_colors.dart';
import '../../../../../../core/config/app_values.dart';
import '../../../../../../data/models/dto/shelf_item_dto.dart';
import '../../../../../../domain/entities/reading_status.dart';

class ReadDate extends StatelessWidget {
  final BookOptionsBloc bloc;
  final ShelfItemDto bookItem;
  final double widthSize;

  const ReadDate({
    super.key,
    required this.bloc,
    required this.bookItem,
    required this.widthSize,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = bookItem.readingStatus == ReadingStatus.read;

    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m16),
      child: BookOptionsActionButton(
        context: context,
        icon: Icon(
          Icons.event_available_rounded,
          color: isEnabled ? AppColors.primaryText : AppColors.disabledText,
        ),
        onTap: isEnabled ? () => _showDatePickerModal(context) : () {},
        width: widthSize * 0.45,
        height: 70,
        title: 'Data de Leitura',
        isEnabled: isEnabled,
      ),
    );
  }

  void _showDatePickerModal(BuildContext context) async {
    // Data inicial para o date picker (data atual ou data salva)
    final initialDate = bookItem.endDate ?? DateTime.now();

    // Mostrar date picker
    final selectedDate = await showDatePicker(
      locale: const Locale('pt', 'BR'),
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    // Se uma data foi selecionada, disparar evento para salvar
    if (selectedDate != null) {
      bloc.add(AddReadDateEvent(
        bookItem.startDate ?? DateTime.now(),
        selectedDate,
        bookItem.bookId,
      ));
    }
  }
}
