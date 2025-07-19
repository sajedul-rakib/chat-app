
import 'package:chat_app/apis/model/response_model.dart';

abstract class LogInRepo {
  //sign in with email and password
  Future<ResponseModel> signIn(
      {required String email, required String password,String fcmToken = ''});
  //check the user weather the user are logged in or not
  Future<String> checkUserLoggedIn();
  //log out
  Future<bool> logOut();
}
