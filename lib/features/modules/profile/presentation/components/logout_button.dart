import 'package:book_app/features/presentation/components/button/primary_button.dart';
import 'package:book_app/core/resources/app_routes.dart';
import 'package:book_app/features/modules/profile/presentation/controller/cubit/profile_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
