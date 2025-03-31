part of 'send_bloc.dart';

@immutable
abstract class SendEvent {}

final class SendMessageRequest extends SendEvent {
  final Map<String, dynamic> message;
  final String conversationId;
  final String token;

  SendMessageRequest(
      {required this.message,
      required this.conversationId,
      required this.token});
}
