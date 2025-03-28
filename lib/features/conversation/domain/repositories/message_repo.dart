import 'package:chat_app/features/conversation/datasource/models/message_model.dart';

abstract class MessageRepo {
  //get corresponding user message
  Future<MessageModel> getMessage({required String conversationId,required String token});
}