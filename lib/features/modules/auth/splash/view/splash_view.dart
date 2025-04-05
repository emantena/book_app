import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../controller/cubit/splash_cubit.dart';
import '../../../../presentation/components/loading_indicator.dart';
import '../../../../../core/resources/app_routes.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          switch (state) {
            case Authenticated _:
              context.pushReplacementNamed(AppRoutes.homeRoute);
            case Unauthenticated _:
              context.pushReplacementNamed(AppRoutes.signInRoute);
          }
        },
        child: const Center(child: LoadingIndicator()),
      ),
    );
  }
}
