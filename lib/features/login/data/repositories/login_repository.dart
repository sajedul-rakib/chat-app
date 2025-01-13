import 'package:firebase_auth/firebase_auth.dart';

abstract class LogInRepository {
  //sign in with email and password
  Future<void> loginWithEmailAndPassword(
      {required String email, required String password});
  // get user data
  Stream<User?> get user;

  //log out
  Future<void> logOut();
}
