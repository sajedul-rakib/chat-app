part of 'send_bloc.dart';

@immutable
abstract class SendEvent {}

final class SendMessageRequest extends SendEvent {
  final Map<String, dynamic> message;
  final String conversationId;

  SendMessageRequest(
      {required this.message,
      required this.conversationId,
     });
}
