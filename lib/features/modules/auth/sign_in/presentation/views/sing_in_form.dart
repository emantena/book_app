import 'package:book_app/core/resources/app_routes.dart';
import 'package:book_app/core/resources/app_strings.dart';
import 'package:book_app/features/modules/auth/sign_in/presentation/components/input_email.dart';
import 'package:book_app/features/modules/auth/sign_in/presentation/components/input_password.dart';
import 'package:book_app/features/modules/auth/sign_in/presentation/components/sign_in_button.dart';
import 'package:book_app/features/modules/auth/sign_in/presentation/controllers/cubit/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../../presentation/components/logo.dart';

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
