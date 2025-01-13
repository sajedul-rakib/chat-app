class LoginwithEmailandpasswordError implements Exception {
  const LoginwithEmailandpasswordError(
      [this.message = 'An unknown exception occurred.']);

  factory LoginwithEmailandpasswordError.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LoginwithEmailandpasswordError(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LoginwithEmailandpasswordError(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LoginwithEmailandpasswordError(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LoginwithEmailandpasswordError(
          'Incorrect password, please try again.',
        );
      default:
        return const LoginwithEmailandpasswordError();
    }
  }

  final String message;
}
