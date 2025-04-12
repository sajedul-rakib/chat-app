import 'dart:developer';

import 'package:chat_app/apis/api_endpoints.dart';
import 'package:chat_app/apis/api_service.dart';
import 'package:chat_app/apis/model/response_model.dart';
import 'package:chat_app/features/conversation/domain/repositories/message_repo.dart';

class MessageRepositories extends MessageRepo {
  @override
  Future<ResponseModel> getMessage(
      {required String conversationId, required String token}) async {
    try {
      final response = await ApiService.callApiWithGetMethod(
          url: ApiEndPoints.getMessage(conversationId), token: token);
      return response;
    } catch (err) {
      return ResponseModel(status: 500,errMsg: {'errMsg':err});
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
