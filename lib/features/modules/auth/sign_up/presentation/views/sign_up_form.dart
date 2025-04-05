import 'package:book_app/features/presentation/components/button/primary_button.dart';
import 'package:book_app/features/presentation/components/logo.dart';
import 'package:book_app/core/resources/app_routes.dart';
import 'package:book_app/core/resources/app_values.dart';
import 'package:book_app/features/modules/auth/sign_up/presentation/controller/sign_up_cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../components/sig_up_form_components.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<SignUpCubit, SignUpState>(
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
          const Padding(padding: EdgeInsets.all(AppPadding.p8), child: InputName()),
          const Padding(padding: EdgeInsets.all(AppPadding.p8), child: InputEmail()),
          const Padding(padding: EdgeInsets.all(AppPadding.p8), child: InputPassword()),
          const Padding(padding: EdgeInsets.all(AppPadding.p8), child: InputBirthDate()),
          const Padding(
            padding: EdgeInsets.all(AppPadding.p8),
            child: SignUpButton(),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: PrimaryButton(
              onPressed: () {
                context.pushReplacementNamed(AppRoutes.signInRoute);
              },
              radius: 45,
              label: "Voltar",
            ),
          ),
        ],
      ),
    );
  }
}
