class ForgotPasswordFailure implements Exception {
  final String message;

  const ForgotPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory ForgotPasswordFailure.fromCode(String code) {
    switch (code) {
      // case 'invalid-email':
      //   return const ForgotPasswordFailure(
      //     'Email is not valid or badly formatted.',
      //   );
      // case 'user-disabled':
      //   return const ForgotPasswordFailure(
      //     'This user has been disabled. Please contact support for help.',
      //   );
      // case 'email-already-in-use':
      //   return const ForgotPasswordFailure(
      //     'An account already exists for that email.',
      //   );
      // case 'operation-not-allowed':
      //   return const ForgotPasswordFailure(
      //     'Operation is not allowed.  Please contact support.',
      //   );
      // case 'weak-password':
      //   return const ForgotPasswordFailure(
      //     'Please enter a stronger password.',
      //   );
      default:
        return const ForgotPasswordFailure();
    }
  }
}
