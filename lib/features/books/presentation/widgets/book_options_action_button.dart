import 'package:flutter/material.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_values.dart';

class BookOptionsActionButton extends StatelessWidget {
  final BuildContext context;
  final Icon icon;
  final VoidCallback onTap;
  final double width;
  final double height;
  final String title;
  final bool isEnabled;

  const BookOptionsActionButton({
    super.key,
    required this.context,
    required this.icon,
    required this.onTap,
    required this.width,
    required this.height,
    required this.title,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor =
        isEnabled ? AppColors.primaryText : AppColors.disabledText;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: icon,
            ),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AppSize.s16,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
