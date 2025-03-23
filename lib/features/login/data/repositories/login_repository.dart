
abstract class LogInRepository {
  //sign in with email and password
  Future<void> signIn(
      {required String email, required String password});
  //check the user weather the user are logged in or not
  Future<void> checkUserLoggedIn();
  //log out
  Future<void> logOut();
}
