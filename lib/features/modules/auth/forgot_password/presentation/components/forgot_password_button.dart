import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../controller/forgot_password_cubit/forgot_password_cubit.dart';
import '../../../../../presentation/components/button/primary_button.dart';
import '../../../../../presentation/components/loading_indicator.dart';

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
