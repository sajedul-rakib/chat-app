import '../models/model.dart';

abstract class SignupRepository {
  //sign up
  Future<void> signUpWithEmailAndPassword(
      {required MyUser user, required String password, required picPath});

  //upload profile pic
  Future<String> uploadProfile({required String picPath});

  //get user data via user id
  Future<MyUser> getUserData({required String userId});
}
