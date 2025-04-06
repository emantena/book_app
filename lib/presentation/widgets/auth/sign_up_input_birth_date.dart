import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_strings.dart';
import '../../../core/config/app_values.dart';
import '../../blocs/sign_up/sign_up_cubit.dart';

class InputBirthDate extends StatelessWidget {
  const InputBirthDate({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final inputTheme = Theme.of(context).inputDecorationTheme;

    final displayError = context.select(
      (SignUpCubit cubit) => cubit.state.birthDate.displayError,
    );

    return TextFormField(
      onChanged: (value) {
        context.read<SignUpCubit>().birthDateChanged(value);
      },
      keyboardType: TextInputType.datetime,
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
        errorText: displayError != null ? 'data de nascimento inválida' : null,
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
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(AppSize.s45),
        ),
        prefixIcon: const Icon(
          Icons.calendar_month_outlined,
          color: AppColors.unselectedColor,
        ),
        hintText: AppStrings.birthDate,
        hintStyle: inputTheme.hintStyle,
      ),
    );
  }
}
