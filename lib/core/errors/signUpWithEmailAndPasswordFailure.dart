class SignUpWithEmailAndPassword implements Exception {
  const SignUpWithEmailAndPassword(
      [this.message = 'An unknown exception occurred.']);

  factory SignUpWithEmailAndPassword.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPassword(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPassword(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPassword(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPassword(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPassword(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPassword();
    }
  }

  final String message;
}
