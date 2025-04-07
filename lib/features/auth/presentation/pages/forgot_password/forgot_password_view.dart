import 'package:flutter/material.dart';

import 'components/forgot_password_form.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ForgotPasswordForm(),
          ),
        ],
      ),
    );
  }
}
