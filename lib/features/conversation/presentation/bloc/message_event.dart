part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

final class GetMessageRequest extends MessageEvent {
  final String conversationId;
  final String token;

  GetMessageRequest({required this.conversationId, required this.token});
}


class NewMessageReceived extends MessageEvent {
  final Message message;
  NewMessageReceived(this.message);
}