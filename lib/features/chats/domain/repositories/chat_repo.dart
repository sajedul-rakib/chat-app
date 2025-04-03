import 'package:chat_app/apis/model/response_model.dart';
import 'package:chat_app/features/chats/data/models/Conversation.dart';

abstract class ChatRepo {
  Future<ResponseModel> getFriendList(String token);

  Future<ResponseModel> searchUser(String token, String keyword);

  Future<ResponseModel> addFriend(String token, Map<String, dynamic> friend);
}
