part of 'message_bloc.dart';

@immutable
abstract class MessageEvent extends Equatable {}

final class GetMessageRequest extends MessageEvent {
  final String conversationId;
  final String token;

  GetMessageRequest({required this.conversationId, required this.token});

  @override
  List<Object?> get props => [conversationId, token];
}

final class SendMessageRequest extends MessageEvent {
  final Map<String,dynamic> message;
  final String conversationId;
  final String token;

  SendMessageRequest(
      {required this.message,
      required this.conversationId,
      required this.token});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
