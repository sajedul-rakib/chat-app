part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

final class GetMessageRequest extends MessageEvent {
  final String conversationId;

  GetMessageRequest({required this.conversationId});
}

class NewMessageReceived extends MessageEvent {
  final Message message;

  NewMessageReceived(this.message);
}
