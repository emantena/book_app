import 'package:book_app/features/modules/auth/sign_up/presentation/views/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SignUpForm(),
          ),
        ],
      ),
    );
  }
}
