import 'package:book_app/core/resources/app_colors.dart';
import 'package:book_app/core/resources/app_strings.dart';
import 'package:book_app/core/resources/app_values.dart';
import 'package:book_app/features/modules/auth/sign_in/presentation/controllers/cubit/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputPassword extends StatelessWidget {
  const InputPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final inputTheme = Theme.of(context).inputDecorationTheme;

    return TextFormField(
      onChanged: (value) {
        context.read<SignInCubit>().passwordChanged(value);
      },
      obscureText: true,
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
          Icons.password_rounded,
          color: AppColors.unselectedColor,
        ),
        hintText: AppStrings.password,
        hintStyle: inputTheme.hintStyle,
      ),
    );
  }
}
