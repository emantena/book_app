import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/app_values.dart';
import '../bloc/profile_cubit.dart';
import 'avatar_image.dart';
import 'input_form.dart';
import 'logout_button.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((ProfileCubit cubit) => cubit.state.user);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (context.select((ProfileCubit cubit) => cubit.state.status) ==
            ProfileStatus.changePhoto) ...[
          AvatarImage(
            photo: user?.photo,
          ),
        ] else ...[
          AvatarImage(
            photo: user?.photo,
          ),
        ],
        const SizedBox(height: AppSize.s16),
        inputForm(context: context, label: user?.name ?? "Nome"),
        const SizedBox(height: AppSize.s16),
        inputForm(context: context, label: user?.email ?? "Email"),
        const SizedBox(height: AppSize.s16),
        inputForm(
          context: context,
          label: user?.birthDate == null
              ? "Data de Nascimento"
              : DateFormat('dd/MM/yyyy').format(user!.birthDate!),
        ),
        const SizedBox(height: AppSize.s16),
        const LogoutButton(),
      ],
    );
  }
}
