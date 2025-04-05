import 'package:book_app/features/modules/profile/presentation/components/profile_form.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: ProfileForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
