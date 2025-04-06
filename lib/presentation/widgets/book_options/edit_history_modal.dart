import 'package:flutter/material.dart';

import '../../../core/ui/components/input_field.dart';
import '../../../data/models/dto/read_history_dto.dart';
import '../../blocs/book_options/book_options_bloc.dart';

class EditHistoryModal extends StatefulWidget {
  final ReadHistoryDto history;
  final BookOptionsBloc bloc;
  final int totalPages;

  const EditHistoryModal({
    super.key,
    required this.bloc,
    required this.history,
    required this.totalPages,
  });

  @override
  EditHistoryModalState createState() => EditHistoryModalState();
}

class EditHistoryModalState extends State<EditHistoryModal> {
  final TextEditingController _controller = TextEditingController();
  String _selectedOption = 'pages';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.history.pages.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Histórico'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InputField(
            onChanged: (value) {
              _controller.text = value;
              setState(() {
                _errorMessage = null;
              });
            },
            controller: _controller,
            hintText: _selectedOption == 'pages' ? 'páginas' : 'porcentagem',
            keyboardType: TextInputType.number,
            obscureText: false,
          ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const SizedBox(height: 16),
          Flexible(
            child: RadioListTile<String>(
              title: const Text('Páginas', style: TextStyle(fontSize: 13)),
              value: 'pages',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                  _controller.clear();
                  _errorMessage = null;
                });
              },
            ),
          ),
          Flexible(
            child: RadioListTile<String>(
              title: const Text('Porcentagem', style: TextStyle(fontSize: 13)),
              value: 'percentage',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                  _controller.clear();
                  _errorMessage = null;
                });
              },
            ),
          ),
        ],
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
            final inputValue = int.tryParse(_controller.text);
            if (_selectedOption == 'pages' && (inputValue == null || inputValue > widget.totalPages)) {
              setState(() {
                _errorMessage = 'O número de páginas não pode ser maior que ${widget.totalPages}.';
              });
            } else if (_selectedOption == 'percentage' && (inputValue == null || inputValue > 100)) {
              setState(() {
                _errorMessage = 'A porcentagem não pode ser maior que 100%.';
              });
            } else {
              int? pages;
              int? percentage;

              if (_selectedOption == 'pages') {
                pages = inputValue;
                percentage = null;
              } else if (_selectedOption == 'percentage') {
                percentage = inputValue;
                pages = null;
              }

              widget.bloc.add(
                SetReadHistoryEvent(
                  widget.history.bookId,
                  pages,
                  percentage,
                  widget.history.id,
                ),
              );

              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
