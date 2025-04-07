import 'package:flutter/material.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_values.dart';

Widget inputForm({required BuildContext context, required String label}) {
  final size = MediaQuery.of(context).size;
  return Container(
    width: double.infinity,
    height: size.height * 0.06,
    margin: const EdgeInsets.only(left: 16, top: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.unselectedColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(AppSize.s45),
    ),
    child: Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16),
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.unselectedColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}
