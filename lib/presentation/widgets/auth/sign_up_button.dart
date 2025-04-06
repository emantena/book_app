import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../core/ui/components/loading_indicator.dart';
import '../../../core/ui/components/primary_button.dart';
import '../../blocs/sign_up/sign_up_cubit.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (SignUpCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const LoadingIndicator();

    final isValid = context.select(
      (SignUpCubit cubit) => cubit.state.isValid,
    );

    return PrimaryButton(
      radius: 45,
      label: "Cadastrar",
      onPressed: isValid
          ? () {
              FocusScope.of(context).unfocus();
              context.read<SignUpCubit>().registerUser();
            }
          : null,
    );
  }
}
