import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/config/app_routes.dart';
import '../../../../../../core/config/app_values.dart';
import '../../../../../../core/ui/components/logo.dart';
import '../../../../../../core/ui/components/primary_button.dart';
import '../../../blocs/sign_up/sign_up_cubit.dart';
import 'sign_up_input_password.dart';
import '../../forgot_password/components/forgot_password_input_email.dart';
import 'sign_up_button.dart';
import 'sign_up_input_birth_date.dart';
import 'sign_up_input_name.dart';

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
