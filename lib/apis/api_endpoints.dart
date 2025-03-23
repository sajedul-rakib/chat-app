import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndPoints{
  static final String  baseUrl=dotenv.env['BASE_URL']?? 'defaultUrl';

  static final signUp= '$baseUrl/signup';
}