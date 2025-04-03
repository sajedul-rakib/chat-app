import 'package:chat_app/apis/model/response_model.dart';

abstract class MessageRepo {
  //get corresponding user message
  Future<ResponseModel> getMessage({required String conversationId,required String token});
}