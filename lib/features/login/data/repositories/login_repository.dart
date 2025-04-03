
import 'package:chat_app/apis/model/response_model.dart';

abstract class LogInRepository {
  //sign in with email and password
  Future<ResponseModel> signIn(
      {required String email, required String password});
  //check the user weather the user are logged in or not
  Future<void> checkUserLoggedIn();
  //log out
  Future<void> logOut();
}
