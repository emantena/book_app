import 'package:book_app/core/resources/app_colors.dart';
import 'package:book_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';

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
