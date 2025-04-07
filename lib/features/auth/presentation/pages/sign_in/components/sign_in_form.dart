import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/config/app_routes.dart';
import '../../../../../../core/config/app_strings.dart';
import '../../../../../../core/ui/components/logo.dart';
import '../../../blocs/sign_in/sign_in_cubit.dart';
import 'sign_in_button.dart';
import 'sign_in_input_email.dart';
import 'sign_in_input_password.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.pushReplacementNamed(AppRoutes.splashRoute);
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Sign In Failure'),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Logo(width: size.width, height: size.height * 0.2),
          ),
          const Padding(padding: EdgeInsets.all(8.0), child: InputEmail()),
          const Padding(padding: EdgeInsets.all(8.0), child: InputPassword()),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SignInButton(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.forgotPasswordRoute);
                },
                child: Text(
                  AppStrings.forgotPassword,
                  style: textTheme.bodyMedium,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.signUpRoute);
                },
                child: Text(
                  AppStrings.signUp,
                  style: textTheme.bodyMedium,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
