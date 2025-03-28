import 'package:chat_app/features/chats/data/models/Conversation.dart';

import '../../data/models/conversation_model.dart';

abstract class ChatRepo {
  Future<ConversationModel> getFriendList(String token);

  Future<void> searchUser(String token, String keyword);

  Future<Conversation?> addFriend(String token, Map<String, dynamic> friend);
}
