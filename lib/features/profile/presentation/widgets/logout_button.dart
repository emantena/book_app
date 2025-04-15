import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/ui/routes/app_routes.dart';
import '../../../../core/ui/components/primary_button.dart';
import '../bloc/profile_cubit.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.logout) {
          context.pushReplacementNamed(AppRoutes.splashRoute);
        }
      },
      child: PrimaryButton(
        radius: 45,
        label: "Sair",
        onPressed: () => context.read<ProfileCubit>().signOut(),
      ),
    );
  }
}
