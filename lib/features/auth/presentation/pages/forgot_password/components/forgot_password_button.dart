import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../core/ui/components/loading_indicator.dart';
import '../../../../../../core/ui/components/primary_button.dart';
import '../../../blocs/forgot_password/forgot_password_cubit.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (ForgotPasswordCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const LoadingIndicator();

    final isValid = context.select(
      (ForgotPasswordCubit cubit) => cubit.state.isValid,
    );

    return PrimaryButton(
      radius: 45,
      label: "Enviar Email",
      onPressed: isValid
          ? () {
              FocusScope.of(context).unfocus();
              context.read<ForgotPasswordCubit>().forgotPasswordSendMail();
            }
          : null,
    );
  }
}
