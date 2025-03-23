import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndPoints{
  //api base url
  static final String  baseUrl=dotenv.env['BASE_URL']?? 'defaultUrl';

  //sign up
  static final String signUp= '$baseUrl/signup';

  //sign in
  static final String signIn='$baseUrl/signin';
}