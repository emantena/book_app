import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/app_colors.dart';
import '../../../../../core/config/app_strings.dart';
import '../../../../../core/config/app_values.dart';
import '../../../../blocs/auth/forgot_password/forgot_password_cubit.dart';

class InputEmail extends StatelessWidget {
  const InputEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final inputTheme = Theme.of(context).inputDecorationTheme;

    final displayError = context.select(
      (ForgotPasswordCubit cubit) => cubit.state.email.displayError,
    );

    return TextFormField(
      onChanged: (value) {
        context.read<ForgotPasswordCubit>().emailChanged(value);
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
        errorText: displayError != null ? 'email inválido' : null,
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
          Icons.email_outlined,
          color: AppColors.unselectedColor,
        ),
        hintText: AppStrings.email,
        hintStyle: inputTheme.hintStyle,
      ),
    );
  }
}
