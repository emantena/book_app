import 'package:flutter/material.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_values.dart';

class BookOptionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookOptionsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      title: const Text(
        'Opções do Livro',
        style: TextStyle(
          color: AppColors.primaryText,
          fontSize: AppSize.s18,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
