import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_values.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p16,
        right: AppPadding.p16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: const Icon(
                Icons.arrow_back_sharp,
                color: AppColors.secondaryText,
                size: AppSize.s24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
