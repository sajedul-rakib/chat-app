import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/logInWithEmailAndPassword.dart';
import '../../data/repositories/login_repository.dart';

class LoginRepo extends LogInRepository {
  final FirebaseAuth _auth;

  LoginRepo({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;
  @override
  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      log('the code : ${e.code}');
      throw LoginwithEmailandpasswordError.fromCode(e.code).message;
    } catch (e) {
      throw const LoginwithEmailandpasswordError().message;
    }
  }

  @override
  Stream<User?> get user {
    return _auth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> logOut() async {
    try {
      _auth.signOut();
    } on FirebaseException catch (e) {
      log(e.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
