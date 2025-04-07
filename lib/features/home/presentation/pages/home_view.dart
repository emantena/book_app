import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.pushNamed(
    //     AppRoutes.bookOptionsRoute,
    //     pathParameters: {'bookId': 'gu7X-YYurTQC'},
    //   );
    // });

    return const Scaffold(
      body: SizedBox(height: 100, width: 100),
    );
  }
}
