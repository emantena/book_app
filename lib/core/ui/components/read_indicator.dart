import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_values.dart';

class ReadIndicator extends StatelessWidget {
  final int totalPagesToRead;
  final int totalReadPages;

  const ReadIndicator({
    super.key,
    required this.totalPagesToRead,
    required this.totalReadPages,
  });

  @override
  Widget build(BuildContext context) {
    double progress = 0;

    if (totalPagesToRead != 0) {
      progress = totalReadPages / totalPagesToRead;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSize.s45),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p4,
                    top: AppPadding.p36,
                  ),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(AppSize.s45),
                    minHeight: AppSize.s8,
                    value: progress,
                    backgroundColor: AppColors.secondary,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: AppPadding.p8, left: AppPadding.p8, top: AppPadding.p36),
                child: Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: AppSize.s12,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppPadding.p4,
              right: AppPadding.p8,
              top: AppPadding.p8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$totalReadPages',
                  style: const TextStyle(
                    fontSize: AppSize.s12,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  '$totalPagesToRead',
                  style: const TextStyle(
                    fontSize: AppSize.s12,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
