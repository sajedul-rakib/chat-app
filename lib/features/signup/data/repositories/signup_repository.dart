import '../models/model.dart';

abstract class SignupRepository {
  //sign up
  Future<bool> signUp(
      {required MyUser user, required String password});
}
