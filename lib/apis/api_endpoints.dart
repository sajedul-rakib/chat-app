import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndPoints {
  //api base url
  static final String baseUrl = dotenv.env['BASE_URL'] ?? 'defaultUrl';

  //sign up
  static final String signUp = '$baseUrl/signup';

  //sign in
  static final String signIn = '$baseUrl/signin';

  //get friend list
  static final String getFriendList = '$baseUrl/conversation';

  //get friend list
  static final String addFriendList = '$baseUrl/conversation';

  //get message url
  static String getMessage(String conversationId) =>
      '$baseUrl/message/$conversationId';

  //send message url
  static String sendMessage(String conversationId) =>
      '$baseUrl/message/$conversationId';

  //search user
  static String search = '$baseUrl/search';

  // get authenticate user detail
  static String userDetail = '$baseUrl/user-detail';

}
