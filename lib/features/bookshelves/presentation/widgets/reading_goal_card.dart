import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../data/models/dto/shelf_item_dto.dart';
import '../../../../domain/entities/reading_status.dart';

class ReadingGoalCard extends StatelessWidget {
  final List<ShelfItemDto> books;
  const ReadingGoalCard({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    final List<ShelfItemDto> booksRead = books
        .where((book) => book.readingStatus == ReadingStatus.read)
        .toList();

    final int yearlyGoal = books.length;

    final double percentage = booksRead.isEmpty
        ? 0.0
        : (booksRead.length / yearlyGoal).clamp(0.0, 1.0);

    final totalPagesRead = booksRead.fold<int>(0, (sum, book) {
      return sum + (book.pages);
    });

    final int totalPages = books.fold<int>(0, (sum, book) {
      return sum + (book.pages);
    });

    final double percentagePages =
        totalPages == 0 ? 0.0 : (totalPagesRead / totalPages).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.track_changes,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Meta de leitura',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                const Spacer(),
                CircularPercentIndicator(
                  radius: 25.0,
                  lineWidth: 5.0,
                  percent: percentage,
                  center: Text(
                    '${(percentage * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  progressColor: AppColors.primary,
                  backgroundColor: AppColors.inactiveColor,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard(
                  'Livros lidos',
                  booksRead.length.toString(),
                  Icons.check_circle_outline,
                ),
                _buildStatCard(
                  'Meta anual',
                  yearlyGoal.toString(),
                  Icons.flag,
                ),
                _buildStatCard(
                  'Faltam',
                  (yearlyGoal - booksRead.length).toString(),
                  Icons.hourglass_empty,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: percentagePages,
                  backgroundColor: AppColors.inactiveColor,
                  color: AppColors.primary,
                  minHeight: 8.0,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$totalPagesRead páginas lidas',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColors.primaryText,
                      ),
                    ),
                    Text(
                      ' de $totalPages páginas',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColors.secondaryText,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
