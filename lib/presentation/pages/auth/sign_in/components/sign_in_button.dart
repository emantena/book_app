import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../core/ui/components/loading_indicator.dart';
import '../../../../../core/ui/components/primary_button.dart';
import '../../../../blocs/auth/sign_in/sign_in_cubit.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (SignInCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const LoadingIndicator();

    return PrimaryButton(
      radius: 45,
      label: "Login",
      onPressed: () {
        FocusScope.of(context).unfocus();
        context.read<SignInCubit>().signIn();
      },
    );
  }
}
