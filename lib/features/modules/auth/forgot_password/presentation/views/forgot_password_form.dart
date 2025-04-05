import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import 'package:book_app/features/presentation/components/button/primary_button.dart';
import 'package:book_app/core/resources/app_routes.dart';
import 'package:book_app/core/resources/app_values.dart';
import 'package:book_app/features/modules/auth/forgot_password/presentation/controller/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:book_app/features/modules/auth/forgot_password/presentation/components/forgot_password_form_components.dart';

import '../../../../../presentation/components/logo.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.pushReplacementNamed(AppRoutes.splashRoute);
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Sign Up Failure'),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Logo(width: size.width, height: size.height * 0.2),
          ),
          const Padding(padding: EdgeInsets.all(AppPadding.p8), child: InputEmail()),
          const Padding(
            padding: EdgeInsets.all(AppPadding.p8),
            child: ForgotPasswordButton(),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: PrimaryButton(
              radius: 45,
              label: "Voltar",
              onPressed: () {
                context.pushReplacementNamed(AppRoutes.signInRoute);
              },
            ),
          ),
        ],
      ),
    );
  }
}
