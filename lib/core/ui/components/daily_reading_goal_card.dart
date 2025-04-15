import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_values.dart';
import '../../../data/models/dto/book_shelf_dto.dart';
import '../../../data/models/dto/read_history_dto.dart';
import '../../../data/models/dto/shelf_item_dto.dart';
import '../../../domain/entities/reading_status.dart';
import '../../../features/books/presentation/blocs/yearly_goals/yearly_goals_bloc.dart';
import '../../../features/bookshelves/presentation/bloc/bookshelf_bloc.dart';

class DailyReadingGoalCard extends StatelessWidget {
  const DailyReadingGoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YearlyGoalsBloc, YearlyGoalsState>(
      builder: (context, yearlyGoalsState) {
        return BlocBuilder<BookshelfBloc, BookshelfState>(
            builder: (context, bookshelfState) {
          // Verificar se temos dados para trabalhar
          if (yearlyGoalsState.books.isEmpty) {
            return _buildEmptyState();
          }

          final int currentYear = DateTime.now().year;

          // Filtrar apenas livros com meta para o ano atual
          final List<ShelfItemDto> booksForCurrentYear = yearlyGoalsState.books
              .where((book) => book.readMeta?.targetYear == currentYear)
              .toList();

          if (booksForCurrentYear.isEmpty) {
            return _buildEmptyState();
          }

          // Calcular o total de páginas para todos os livros com meta no ano atual
          final int totalPagesToRead = booksForCurrentYear.fold(
              0, (sum, book) => sum + _getPendingPages(book));

          // Calcular dias restantes no ano
          final DateTime today = DateTime.now();
          final DateTime endOfYear = DateTime(currentYear, 12, 31);
          final int daysLeft = endOfYear.difference(today).inDays + 1;

          // Calcular páginas por dia necessárias para atingir a meta
          final double pagesPerDay = totalPagesToRead / daysLeft;

          // Calcular média de páginas lidas por dia até agora
          final double currentPagesPerDay = _calculateCurrentReadingPace(
              bookshelfState.bookshelf, currentYear);

          return _buildGoalCard(
            totalPagesToRead: totalPagesToRead,
            daysLeft: daysLeft,
            pagesPerDay: pagesPerDay,
            currentPagesPerDay: currentPagesPerDay,
            booksRemaining: booksForCurrentYear.length,
          );
        });
      },
    );
  }

  // Calcula quantas páginas ainda precisam ser lidas
  int _getPendingPages(ShelfItemDto book) {
    if (book.readingStatus == ReadingStatus.read) {
      return 0; // Livro já foi lido completamente
    } else if (book.readingStatus == ReadingStatus.reading) {
      return book.pages -
          book.currentPage; // Considerar apenas páginas restantes
    } else {
      return book.pages; // Livro ainda não começou a ser lido
    }
  }

  // Calcula a média de páginas lidas por dia no ano atual
  double _calculateCurrentReadingPace(BookShelfDto bookshelf, int currentYear) {
    // Pegar todos os históricos de leitura
    final List<ReadHistoryDto> allHistories = [];

    for (var book in bookshelf.books) {
      allHistories.addAll(book.readHistory);
    }

    // Filtrar apenas os históricos do ano atual
    final List<ReadHistoryDto> thisYearHistories = allHistories
        .where((history) => history.dateRead.year == currentYear)
        .toList();

    if (thisYearHistories.isEmpty) {
      return 0; // Não há registro de leitura este ano
    }

    // Calcular o total de páginas lidas este ano
    final int totalPagesReadThisYear =
        thisYearHistories.fold(0, (sum, history) => sum + (history.pages ?? 0));

    // Encontrar a data do primeiro registro deste ano
    final DateTime firstReadDate = thisYearHistories
        .map((history) => history.dateRead)
        .reduce((a, b) => a.isBefore(b) ? a : b);

    // Calcular dias desde o primeiro registro até hoje
    final DateTime today = DateTime.now();
    final int daysSinceFirstRead = today.difference(firstReadDate).inDays + 1;

    // Calcular a média diária
    return totalPagesReadThisYear / daysSinceFirstRead;
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
        ),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.assessment_outlined,
                size: 28,
                color: AppColors.primary,
              ),
              SizedBox(width: AppSize.s12),
              Text(
                'Meta diária de leitura',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s12),
          Text(
            'Defina suas metas de leitura para o ano atual para ver quantas páginas você precisa ler por dia.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard({
    required int totalPagesToRead,
    required int daysLeft,
    required double pagesPerDay,
    required double currentPagesPerDay,
    required int booksRemaining,
  }) {
    final formattedPagesPerDay = pagesPerDay.ceil(); // Arredondamos para cima
    final formattedCurrentPace =
        currentPagesPerDay.toStringAsFixed(1); // Uma casa decimal

    // Determinar se o ritmo atual é suficiente
    final bool onTrack = currentPagesPerDay >= pagesPerDay;
    final Color paceColor = onTrack ? AppColors.read : AppColors.rereading;
    final String paceMessage = onTrack
        ? 'Você está no ritmo certo!'
        : 'Você precisa aumentar seu ritmo de leitura.';

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.auto_awesome,
                size: 28,
                color: AppColors.primary,
              ),
              SizedBox(width: AppSize.s12),
              Text(
                'Meta diária de leitura',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPaceInfo(
                value: '$formattedPagesPerDay',
                label: 'Meta diária',
                color: AppColors.primary,
              ),
              Container(
                height: 50,
                width: 1,
                color: AppColors.inactiveColor,
              ),
              _buildPaceInfo(
                value: formattedCurrentPace,
                label: 'Ritmo atual',
                color: paceColor,
              ),
            ],
          ),
          const SizedBox(height: AppSize.s8),
          Center(
            child: Text(
              paceMessage,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: paceColor,
              ),
            ),
          ),
          const SizedBox(height: AppSize.s16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat(
                value: totalPagesToRead.toString(),
                label: 'Páginas restantes',
                icon: Icons.menu_book,
              ),
              _buildStat(
                value: daysLeft.toString(),
                label: 'Dias restantes',
                icon: Icons.calendar_today,
              ),
              _buildStat(
                value: booksRemaining.toString(),
                label: 'Livros planejados',
                icon: Icons.auto_stories,
              ),
            ],
          ),
          const SizedBox(height: AppSize.s8),
          Text(
            'Para atingir sua meta de leitura até 31/12/${DateTime.now().year}',
            style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: AppColors.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPaceInfo({
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildStat({
    required String value,
    required String label,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.secondary,
        ),
        const SizedBox(height: AppSize.s4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.secondaryText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
