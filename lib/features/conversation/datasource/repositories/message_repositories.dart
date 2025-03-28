import 'dart:developer';

import 'package:chat_app/apis/api_endpoints.dart';
import 'package:chat_app/apis/api_service.dart';
import 'package:chat_app/features/conversation/datasource/models/message.dart';
import 'package:chat_app/features/conversation/datasource/models/message_model.dart';
import 'package:chat_app/features/conversation/domain/repositories/message_repo.dart';

class MessageRepositories extends MessageRepo {
  @override
  Future<MessageModel> getMessage(
      {required String conversationId, required String token}) async {
    try {
      final response = await ApiService.callApiWithGetMethod(
          url: ApiEndPoints.getMessage(conversationId), token: token);
      return MessageModel.fromJson(response.body);
    } catch (err) {
      log('error from message repo: $err');
      rethrow;
    }
  }

  Future<bool> sendMessage(
      Map<String,dynamic> message, String conversationId, String token) async {
    try {
      final response = await ApiService.callApiWithPostMethod(
          url: ApiEndPoints.sendMessage(conversationId),
          body: message,
          token: token);
      return response.status==200? true: false;
    } catch (err) {
      log("error from msg repo: $err");
      return false;
    }
  }
}
