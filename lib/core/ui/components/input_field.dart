import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_values.dart';

class InputField extends StatelessWidget {
  final Icon? prefixIcon;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const InputField({
    super.key,
    this.prefixIcon,
    required this.hintText,
    required this.keyboardType,
    required this.obscureText,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final inputTheme = Theme.of(context).inputDecorationTheme;

    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: AppColors.primaryText,
      cursorWidth: AppSize.s1,
      style: textTheme.bodyLarge,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade400,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
          borderRadius: BorderRadius.circular(AppSize.s45),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.unselectedColor,
          ),
          borderRadius: BorderRadius.circular(AppSize.s45),
        ),
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: inputTheme.hintStyle,
      ),
    );
  }
}
