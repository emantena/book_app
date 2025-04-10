import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/app_colors.dart';
import '../../../../../core/config/app_routes.dart';
import '../../../../../core/ui/components/image_with_shimmer.dart';
import '../../../../../core/ui/components/loading_indicator.dart';
import '../../../../../core/utils/enum_types.dart';
import '../../blocs/yearly_goals/yearly_goals_bloc.dart';

class YearlyGoalsView extends StatefulWidget {
  const YearlyGoalsView({super.key});

  @override
  State<YearlyGoalsView> createState() => _YearlyGoalsViewState();
}

class _YearlyGoalsViewState extends State<YearlyGoalsView> {
  final int _currentYear = DateTime.now().year;
  late int? _selectedYear = _currentYear;

  @override
  void initState() {
    super.initState();
    // Carrega os livros para o ano atual ao iniciar
    context.read<YearlyGoalsBloc>().add(LoadBooksByYearEvent(_selectedYear));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metas Anuais de Leitura'),
      ),
      body: Column(
        children: [
          _buildYearSelector(),
          Expanded(
            child: BlocBuilder<YearlyGoalsBloc, YearlyGoalsState>(
              builder: (context, state) {
                if (state.status == RequestStatus.loading) {
                  return const Center(child: LoadingIndicator());
                } else if (state.status == RequestStatus.loaded) {
                  if (state.books.isEmpty) {
                    return _buildEmptyState();
                  }
                  return _buildBooksList(state.books);
                } else if (state.status == RequestStatus.error) {
                  return Center(child: Text('Erro: ${state.errorMessage}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildYearChip(null, 'Não sei'),
            _buildYearChip(_currentYear, _currentYear.toString()),
            _buildYearChip(_currentYear + 1, (_currentYear + 1).toString()),
            _buildYearChip(_currentYear + 2, (_currentYear + 2).toString()),
            _buildYearChip(_currentYear + 3, (_currentYear + 3).toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildYearChip(int? year, String label) {
    final isSelected = _selectedYear == year;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedYear = year;
            });
            context.read<YearlyGoalsBloc>().add(LoadBooksByYearEvent(year));
          }
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    final yearText = _selectedYear == null ? 'sem ano definido' : 'no ano $_selectedYear';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.menu_book_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum livro na meta $yearText',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Defina metas anuais para seus livros\npara vê-los listados aqui.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksList(List<dynamic> books) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: ImageWithShimmer(
                width: 60,
                height: 90,
                imageUrl: book.imageUrl,
              ),
            ),
            title: Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              'Meta: ${_selectedYear == null ? "Sem ano definido" : "Ler em $_selectedYear"}',
              style: const TextStyle(
                color: AppColors.primary,
              ),
            ),
            onTap: () {
              context.pushNamed(
                AppRoutes.bookDetailRoute,
                pathParameters: {'bookId': book.bookId},
              );
            },
          ),
        );
      },
    );
  }
}
