import 'package:flutter/material.dart';

import 'sign_in_form.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    // O BlocProvider é fornecido no GoRouter, então não precisamos criá-lo aqui
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SignInForm(),
          ),
        ],
      ),
    );
  }
}
