import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/config/app_colors.dart';
import '../../../../../../core/config/app_strings.dart';
import '../../../../../../core/config/app_values.dart';
import '../../../blocs/sign_in/sign_in_cubit.dart';

class InputEmail extends StatelessWidget {
  const InputEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final inputTheme = Theme.of(context).inputDecorationTheme;

    return TextFormField(
      onChanged: (value) {
        context.read<SignInCubit>().emailChanged(value);
      },
      keyboardType: TextInputType.text,
      cursorColor: AppColors.primaryText,
      cursorWidth: AppSize.s1,
      style: textTheme.bodyLarge,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s45),
          borderSide: const BorderSide(
            color: AppColors.unselectedColor,
          ),
        ),
        fillColor: Colors.grey.shade400,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.unselectedColor,
          ),
          borderRadius: BorderRadius.circular(AppSize.s45),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
          borderRadius: BorderRadius.circular(AppSize.s45),
        ),
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: AppColors.unselectedColor,
        ),
        hintText: AppStrings.email,
        hintStyle: inputTheme.hintStyle,
      ),
    );
  }
}
