import 'package:flutter/material.dart';

import '../../../../../../../core/config/app_colors.dart';
import '../../../../../../../core/ui/components/primary_button.dart';
import '../../../../../../../data/models/dto/shelf_item_dto.dart';
import '../../../blocs/book_options/book_options_bloc.dart';

class NewReadMetaModal extends StatefulWidget {
  final ShelfItemDto bookItem;
  final BookOptionsBloc bloc;

  const NewReadMetaModal({
    super.key,
    required this.bloc,
    required this.bookItem,
  });

  @override
  NewReadMetaModalState createState() => NewReadMetaModalState();
}

class NewReadMetaModalState extends State<NewReadMetaModal> {
  int? _selectedYear;
  final int _currentYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    // Inicializa com o valor atual se já existir
    if (widget.bookItem.readMeta != null) {
      _selectedYear = widget.bookItem.readMeta!.targetYear;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meta de Leitura Anual',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Em qual ano você pretende ler "${widget.bookItem.title}"?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _buildYearOptions(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.bookItem.readMeta != null) ...[
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      widget.bloc.add(RemoveReadMetaEvent(widget.bookItem.bookId));
                      Navigator.pop(context);
                    },
                    radius: 45,
                    label: "Remover Meta",
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: PrimaryButton(
                  onPressed: _selectedYear != null
                      ? () {
                          widget.bloc.add(
                            SetReadMetaEvent(
                              bookId: widget.bookItem.bookId,
                              targetYear: _selectedYear,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      : null,
                  radius: 45,
                  label: "Salvar",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildYearOptions() {
    return Column(
      children: [
        // Opção para o ano atual
        _buildYearTile(_currentYear),

        // Opções para anos futuros
        _buildYearTile(_currentYear + 1),
        _buildYearTile(_currentYear + 2),
        _buildYearTile(_currentYear + 3),

        // Opção "Não sei"
        ListTile(
          title: const Text('Não sei'),
          leading: Radio<int?>(
            value: null,
            groupValue: _selectedYear,
            activeColor: AppColors.primary,
            onChanged: (int? value) {
              setState(() {
                _selectedYear = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildYearTile(int year) {
    return ListTile(
      title: Text(year.toString()),
      leading: Radio<int?>(
        value: year,
        groupValue: _selectedYear,
        activeColor: AppColors.primary,
        onChanged: (int? value) {
          setState(() {
            _selectedYear = value;
          });
        },
      ),
    );
  }
}
