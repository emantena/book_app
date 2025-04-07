part of 'splash_cubit.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class Authenticated extends SplashState {
  final UserModel user;

  Authenticated(this.user);
}

class Unauthenticated extends SplashState {}
